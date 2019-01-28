Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07149C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:24:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91B02087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d/5ffhg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91B02087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q7lgYt3hBwfnyskH8v6og6SJ84BAHndEB9WAiO0YIEU=; b=d/5ffhg9/tFfUr
	THC/X4guCEMlSePXyxvXPqhCjyh4/QBZwtcl2V2Nzy1Q1OjYp13Davgj5yaSy2t+uSEKmLOu0QrB6
	G+5ofpnGQ9GEnx5ZilrV2xSM+3NnbH3Jq7E8GgOdkUtfL5bEEuthHJfLZWjsxqAAwqBilfIFcUKqN
	C1wbqB1zzB1mN1nWYSNXpKFsWWYTKb8N7ptCVkeBeJllYiZdn/WXxAvcNe6kvdQN/Mx+tnU6ZokiS
	eEy2y9lUGe6siOmCxT+B8udRWE54g2Et5JNMjJO76szqUN8yV8yBxL3n6kapJDGRhoZHTI+GdAWJI
	36U5dIpoIPPMLjlvHl+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go38v-0000t6-P4; Mon, 28 Jan 2019 09:23:49 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go38s-0000sY-6F
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:23:48 +0000
Received: from [192.168.178.52] ([109.104.36.222]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MbRXd-1hLB692OLZ-00bsqU; Mon, 28 Jan 2019 10:23:36 +0100
Subject: Re: [PATCH RFC V2 0/4] pinctrl: bcm2835: improve libgpiod output
To: Linus Walleij <linus.walleij@linaro.org>
References: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
 <CACRpkdb1fUYz+a9QrO_jEcKgMNJO3ApZAVDR0gqz_Hd=WVQ35g@mail.gmail.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <1363edbf-51cf-54d4-e2a2-79ee4c3e501b@i2se.com>
Date: Mon, 28 Jan 2019 10:23:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdb1fUYz+a9QrO_jEcKgMNJO3ApZAVDR0gqz_Hd=WVQ35g@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:/Lkkf5kp/q9cqTfMGlAyiRmn87X8Dwp35wY6ITTbUEUABMFGSS9
 lyr1O/5EU1+JvrJ+QoJHv82U1l+vsZWfgr+EE2Wk69WH8imKVdwgY+hHm2ndGfaHGc87gAs
 U7tZuaEtFq+jRiMaEydb34OD6slruCVz/f/iot+YXdGPQrjZ/ixGdTb7KsFew6URbXJY8R7
 yAtcnkCBkw/YFNM2BmJZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:++5xxMD4tmM=:aGwH8oUiAzrQ9hBQQT8TO1
 LIfbAavW7/aVTZghDUzylMEfn229GMU+r9nZesRAkU/1HNS+euL9WpCfemAM3If4kEEO9jTQH
 /oRNcEBtwHTSt2sc4bKBMzqQiTLKWsxPvLEkYkhW3AnuaKmdmAWQO5Ow0Zv9DMhDeL7ctJSo3
 ffKTt4Jx8TMaVrPChYmrzBMwhARPz7yrQaKMirvrKV7PuQcYQUx8e8As76dF1DHX72Fvw+qss
 cL0Od5N6GiQ9btoZwZW8p3CCmoX9RTHirswUX5qNXf24CUOw0bkKgNM14ipperxGHR51tGqGV
 WaHRiKIlUf0gH5LRr1y1FSa91Ri+DGWrKvwo9e5cxqDiKmPmrA7m68NAB7yR5J/LDKSIIXdO5
 jtRfBc2bMfKBSAvliTVyHaM7ykKVqgoDZx5fxuydfQH8vg8+TDDsPo1UnXp7y8baOKrNtN+U2
 LjODNHO5QsbhoUL6tu2upfGQ7o+EZQZSB9cIz1Ws/zKRSieAnfODEz0669m/KF6mIhgcyjJWh
 cwDh2s3BCTyaeTK20puH+y4bNtuQUnNbgUYhtGkkEWRVJhJZ8irGvxGj2IbrcS9IipiykfbFQ
 r11ND1Zrpv91Y1BRnaMEDtlDikfJIFkySuq5MoDE51BLQWGyfexZXqtdi2tSJMwymm60W0qEL
 ob1WYM5EUsPvcDPHk5qJbZntNhxZ82XZ9toamOKZgByvTDebhRS0603hi8RB4QIvxGhwFnGPL
 QNlrdBAyI3iPnID6b5VdW6fFOCG4KG55FtqPBBRP3BpYEfNI8bRJdWUuajk=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_012346_523261_9E43BD1C 
X-CRM114-Status: GOOD (  11.22  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Eric Anholt <eric@anholt.net>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

Am 28.01.19 um 09:06 schrieb Linus Walleij:
> On Mon, Jan 21, 2019 at 8:11 AM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
>> Based on a recent discussion [1],[2] about the unexpected output of gpioinfo
>> this patch series tries to improve the situation. Patches 1-3 are specific
>> changes for bcm2835 while the last one is the intended improvement for gpiolib.
>>
>> Changes in V2:
>> - take strict mode into account as suggested by Linus
>> - add bcm2835 specific changes
> Ooops started to apply this but now I noticed it's in RFC state so I
> backed them out and wait for a non-RFC version first.

i will split this series and resend the non-controversial part (Patch 1+2).

Stefan

>
> Yours,
> Linus Walleij
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
