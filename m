Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2D6C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:02:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEF720656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a0riHinw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEF720656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LQVFGrM415bh0pRIgEvwUCPCmiagNB9wTJZVKrFshFE=; b=a0riHinwpW31hRpxA/I3R5Qkp
	w5nXABZYzEEar8cmiBBwiGN4j6qfaGngWnR0cvqKF+fnxdJaZTixbU1Xhpkh5h502WwKuExdXwjHo
	nUVWriAYVWOp+FrsHbd3gLuysXsSWZWcCh9yG82Zn1IZsJKaLzfN+BPrSo7sMjrRGJ8T+eZAbgQ7X
	DJdMmjZa262V1aAT1GKdDSeCX2DMqTjKHLM011Dmyk8c3VbOjTXaAVfHZ9YlXOzg8YcRi3O3GJK/o
	iQIFraVDZa2CI0g9xVfRvOpUgzf3NIwZuVoA7YKqfYRCE6CC+SS4p70Disf4Q8fSDioRX7PdPOu8/
	YL8FZqRbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj0wV-0004pr-2K; Mon, 14 Jan 2019 12:02:11 +0000
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj0wR-0004pB-V0
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 12:02:09 +0000
Received: from [192.168.178.52] ([109.104.38.213]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MSbov-1gpmJP085J-00SuZE; Mon, 14 Jan 2019 13:01:54 +0100
Subject: Re: [PATCH 1/2] mmc: sdhci-iproc: handle mmc_of_parse() errors during
 probe
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1545598758-4502-1-git-send-email-stefan.wahren@i2se.com>
 <CAPDyKFpTW07CsemS1=0kTEc88-ZXb6+HUVaviGb+8eWBOyRjvA@mail.gmail.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <675cab05-164f-fd72-9d87-1506dc5a6b7a@i2se.com>
Date: Mon, 14 Jan 2019 13:01:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpTW07CsemS1=0kTEc88-ZXb6+HUVaviGb+8eWBOyRjvA@mail.gmail.com>
Content-Language: de-DE
X-Provags-ID: V03:K1:kMrikdgNWplW4+0BImy6MXrqpJK10eXqVOnOlzwp7z/kWEduTSy
 Rn4/GMXGdFz4kl2XM405R3RjHjTPeirVNO6MUc8+RB7spFgpg29My+LHVzAatmNklJn2Glb
 TAoCwW4K4kpcUfNDib++zG93F1bSUAuyjMVq3OyEj+W3eI0bLMWi9jDws+/tBvuqSImWw0W
 7KrjuKnw7wrNEpbdYsb1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KhobI4Yj1is=:USnNjiF4iBetfuJxSnXphb
 ERpiLFFhf0GT42xlCynPieo5IfRdAXfn9tId27VHztgIznKaDRQfW5mVqWug69HmR9NXO4698
 hCBPMK8twxFqh6sPCIMmHHUE0H7AI9TmoJvLHbFqHERQoUoAb86/afNUBtkSk7Ra2VTvaNilO
 G07i57mzExd65hPc17UP7tqQAajzq3wDkD33ZCgeS7ZtZKLCPHiQLvQJEYS0n5bBXabswA0/3
 yZVKBTYjbhKObF02siKpFYXt+pYIm4tyJhBHbWXNd4cCqrackcTMSNWkUDcgGZv8lqAluEX3k
 tkmiMZPtZ5ve6RILF8sZvgIypU5v0lf3PLX0jlhtken068SxORIDBCQaMHnp05R2VP9SEqdrV
 9JnRX2AY0+5ziJE3Cx/0iU6KbNIy5wQty5zQaXhTUa82mG2j5dBcAc4yPkFGT/qYwtXewcwsD
 m3xIMpOIlUZUN5w2xmG1yYJa4IrQVk8E6+w6jJkTFMNQWHM5fcMAOpTpW4DIDOb7E2fQ2kpcf
 KZRV/A61BwogAkVWvp8LDR35O17VwgbpHuD5VriRUxDkZatX3bDBujOj68ReV7WFlgYoH12DT
 K2jfit6O6Xv9YyZZeSOWqMtUBrHhObHbUq7xlaiuLCXPLd697/vAlOkP+TP8CP0w0od+C/0XL
 ZEZiYUTuHa1TuLGuhKktCkTL4wPwXBh74GB+ESr6kA/rAFq9PHHd7iNPbDuWRQs2i8hxy3yCh
 xXJA7sIAioLuKJhXQd5As5TNeM9fIpJIPh/IIKA32j9djDVTxaWZLOd0xi8=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_040208_300195_73EF472F 
X-CRM114-Status: GOOD (  13.62  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Al Cooper <alcooperx@gmail.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, "# 4.0+" <stable@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ulf,

Am 14.01.2019 um 12:44 schrieb Ulf Hansson:
> On Sun, 23 Dec 2018 at 22:00, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> We need to handle mmc_of_parse() errors during probe.
>>
>> This finally fixes the wifi regression on Raspberry Pi 3 series.
>> In error case the wifi chip was permanently in reset because of
>> the power sequence depending on the deferred probe of the GPIO expander.
>>
>> Fixes: b580c52d58d9 ("mmc: sdhci-iproc: add IPROC SDHCI driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Applied for next, thanks!

since this fixes a regression can this applied to fixes, please?

Stefan


>
> Kind regards
> Uffe
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
