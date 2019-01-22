Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7E5C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:59:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E282084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="buRAhoEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E282084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QEFotDMBCrXDqE700trMeTDchsTAKf9FJfQmRrDxFrc=; b=buRAhoEiNcSpHU
	ljv4yzl6ctXp1pGNglXJdk/w/hLzNtlpklP0pCnbIcLCctj9aCGrt7jR5VGJc6r0ZQPBK7iT7xpXC
	d91KLnMWUrunRMmmtYOVQV6EKllA62NM9IjPvXI/s/cIuAll4nZeBZTCJm74Tali83wX3p9HJ+Tmf
	xA4+Z6tsB4haTSzJ/tOP5UmePnTOY7EXsDaggQQI0AXPICRriVTxcGIoHueccoVY03YQraCyGGNRH
	TFnv/u0ww3M/V9r8dTRrBVDCJAfa0l2/Ijrftzo36dfoLqdz7GLYCKBf0z4eJSzYBBBC4jtxqGhuz
	vJ+4Fgt8Zgku+achSGQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glqy0-0001Zu-DP; Tue, 22 Jan 2019 07:59:28 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glqxx-0001ZU-BA; Tue, 22 Jan 2019 07:59:26 +0000
Received: from [192.168.178.52] ([109.104.35.154]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MvJsF-1h3WJ31NMP-00rGmK; Tue, 22 Jan 2019 08:59:16 +0100
Subject: Re: [PATCH] ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl
To: Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
References: <1548003960-4807-1-git-send-email-stefan.wahren@i2se.com>
 <87y37d3gbv.fsf@anholt.net>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <2c95729b-bf41-fa39-44d8-db100d2670a0@i2se.com>
Date: Tue, 22 Jan 2019 08:59:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87y37d3gbv.fsf@anholt.net>
Content-Language: en-US
X-Provags-ID: V03:K1:e8mGLBiPDM/mUVHlmHyt1vXMSRtDxdblPwFtgC9vEGao9Ivj1Ul
 xa8S57VFQz/qQsdGNhjMbvc+D3X01sM1i40MJXaofF2KXOHPkNUTZPZAr+H5YR1AXq741/m
 MPAaJXiadnNeP8R/g24YCnGYMpZ3yUsZNjS7pUIfe6b4LSWaM9qs+st6ps/3qsfsebDZtag
 ffdOV9+txudbaa6tFyblQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UtiC+TgLZD0=:Rle0yPQHUufzJfKpAR9Ov6
 NvE8pPri7OyfksFaYPD2LeujTa+IyAUNOAgQrihNdqPXDOJJ/UMTahuIKLyDEE++Rrb9X1F34
 IgFmHNtwInGGWufazhl5Ffp8j1v8V1IKG6++hP1IXoDTYwGYtq7CWuoLIZFgGaUBb225PHJDZ
 Xa5soB4bkx+SoKI4crvXpQmkv4+s3hUYgsl5NxQZP/pGRdJtM7j3v4NtclUhaEnAQYQYvSgk8
 1GYWhN1uldOebiPG3B9kuM/6/WtNp1TkN39Dkt4WJrc1vIF/3ZYZSEMU+U1MHOj07tWAdQlZf
 4+JOqudTmXyyvTPQd4uzOALJfgXaVL9jK2Zw929wlBuQBhe33+P1dw98XLS7QjBmI7FLCkP1v
 Zlshjw8K9x5saQyL6SpmkbLhZsDCE9nXl0dZdeuQbGxoz0ru6lWqSEs7J6YvML2w04F40FT71
 QvVZbRwsKoMiy/0l5z2oQDI9zcf+qwkWqvSed0mWX7SFDXIkKSO9VAplrDCFJFVZg1DVF3c93
 RnLZeBueJnn4DP54X18ge+DyH5OmnPMSwxcrEWiXg9dIrJiHQ5RwQ5MUwQLBXT6w+lrJIMG0p
 BgvU0tIZGwuktmRy61uHxxMnXC5PkDTFc/zretvZXBQmgpMqP1Eiq5U0vwvS2/aXpPknU96TF
 gXyDKeL0MloPI6U80r+nkkYNMEbUCAWlwdyCx6t9EE6tOLB87UpBnzKsfyF/F6JkeoZf2j5FO
 fO6pJ2lsG8782W8zNOZvCtTXdHvaySss5UQ2pBfBXByql4JlxdpVF9GRKKE=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_235925_687625_A664356F 
X-CRM114-Status: GOOD (  12.08  )
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
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am 21.01.19 um 21:29 schrieb Eric Anholt:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
>
>> There is no need to specify a pinctrl for the reset GPIO. So we better
>> remove this avoid a potential conflict between pinctrl and pwrseq
>> after the pinmux driver has been changed to strict:
>>
>> pinctrl-bcm2835 20200000.gpio: pin gpio41 already requested by wifi-pwrseq;
>> cannot claim for pinctrl-bcm2835:499
>> pinctrl-bcm2835 20200000.gpio: pin-41 (pinctrl-bcm2835:499) status -22
>> pwrseq_simple: probe of wifi-pwrseq failed with error -22
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>

Applied to bcm2835-dt-next

Thanks


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
