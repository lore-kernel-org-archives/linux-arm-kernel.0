Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URI_HEX autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96425C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:38:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E00214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T4r++vUY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/JdHOTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E00214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M4g35DYLis6zR3TXJIvTvoI91BxNVQG0zxfcPTfKdtw=; b=T4r++vUYYo5mwL
	yZxYfO+AwdqW2sgr5dwpFN4vmKIecEvTQjkqRqL/sKkFLyb+ikKvsPwy1zjd3D5t2aTgdAEiNLaUG
	Vm+A5dNZ30TS7DS0jmeKCc5yVt9JvtDg3SO7k4nf0poBNrX2TkmwNlOOA9ituFSwiJJXTxclu9DA4
	iKNA67R/BMBedgTDj6oDcohBonqbxgInlcGyDNI5g/88DhZARZAU7D2Lr8w2062BnIdOuOX25ApPd
	ya/hObQIw+0tjuHD4cHulbsip4wzAyUuigI7wyAn88PDdnFutBXVJDOEab4WjXroGEQap+86oAesw
	xNqUiJez/brjS4p5O5dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghbTJ-0003lB-Mt; Thu, 10 Jan 2019 14:38:13 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghbTG-0003kA-Hn
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 14:38:12 +0000
Received: by mail-wr1-x441.google.com with SMTP id v13so11642396wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 06:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+zBpDDhECaWA4EBkDI+7tfihYPVUH2Fx0JQFyPg7mJE=;
 b=c/JdHOTnP4ODfK/QPl5jPohOKusObD4Wc7AyY6wD1zWUKl7243tXVjxLOHC/vCqIC6
 Hvyn8LG6ZyDRdhcJXpbkBnSYgW/2XVaof5YCjfzVmOJrZ+3KLWUVZAXKX6Xxv/mrU5AC
 nKSjuMoRov0hcVCiaEc/gNm52lYIATfKuzsxQHF/54Qs0se6AbAXNKWM8jPwz4X8w6UF
 kAyVGY8xuZhLFIbrr0RDlj7idRGpaCC86EeMBHG38gbXXsgXCWULZLg0LaeOSm2X9lB0
 AdUFr1i/krTwJ378TWsYoSA1CuZYZi/2qkEFHvJ/bg3nCb43EypAbUqs0UrRFXUMJDJL
 TTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+zBpDDhECaWA4EBkDI+7tfihYPVUH2Fx0JQFyPg7mJE=;
 b=pwYb6v3X8sbhVIoA68v/tmOx/r6rV+GP26TI/9rxLmYW5Kf0PCJrh81/OLTxx+Deqi
 VXvpaRy1DMPsnmhSe+IhKcvviMPMO2rN1zbVJ4yFs4t08T5FssWndZnHJOIuF33OxT6m
 kJ8C1tL1k8XdWTI1lNjZKONU1iMx0/xuuAcCL0XtkvZeLSAsvo6S0vKNxbojnweJcbhj
 6Wr2rtOgUaY1a+1hIT9+dZChRl0o1plATZUWxf9ycahhoXqwKxfmZebSVyTCondnc0cc
 Tq+qFrwqf1RD0LJXCYwugeuVYM8uc9JIHX8hQHim/WANBLvDqwhE1jBS4v21hxC/8x3e
 Z9mg==
X-Gm-Message-State: AJcUukczjT0zu1O5OGvm0v45gNhgLDaM7IkqSGJ1oXoEDs5vHA2WmSXY
 UgaqZR9BK/Ns5ScOduild/w=
X-Google-Smtp-Source: ALg8bN5+Zaj68GHQzbDIi9s5CZm9At9aKhk4zbEwNfPMg1AyurajUk0zFlXufAmHxgB1STYe7exlLA==
X-Received: by 2002:adf:f101:: with SMTP id r1mr9739441wro.32.1547131088035;
 Thu, 10 Jan 2019 06:38:08 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz.
 [86.49.110.70])
 by smtp.gmail.com with ESMTPSA id x20sm22068984wme.6.2019.01.10.06.38.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 06:38:07 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Fix backlight
 regulator numbering
To: Simon Horman <horms@verge.net.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20190109140045.17449-1-marek.vasut@gmail.com>
 <CAMuHMdX3bP_WCYNRRMmVRPwV52e72NOZMtW8cf29Fo+E9_CvcQ@mail.gmail.com>
 <20190109165822.tmj7qbho46f7clvg@verge.net.au>
 <20190110100202.4eqyge7vadlmodsy@verge.net.au>
From: Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <33d99771-695e-97ba-dfcb-25e08c91d300@gmail.com>
Date: Thu, 10 Jan 2019 14:40:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190110100202.4eqyge7vadlmodsy@verge.net.au>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_063810_610700_4E53B211 
X-CRM114-Status: GOOD (  22.38  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/10/19 11:02 AM, Simon Horman wrote:
> On Wed, Jan 09, 2019 at 05:58:23PM +0100, Simon Horman wrote:
>> On Wed, Jan 09, 2019 at 04:26:25PM +0100, Geert Uytterhoeven wrote:
>>> On Wed, Jan 9, 2019 at 3:01 PM <marek.vasut@gmail.com> wrote:
>>>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>
>>>> There are two regulator1 nodes in the Ebisu DTS right now, one 3.3V for
>>>> the eMMC and one 12V for the backlight. This causes one to be overwritten
>>>> by the other, ultimatelly resulting in inoperable eMMC, which depends on
>>>> the former. Fix this by renumbering the backlight regulator to regulator2.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>> Reported-by: Simon Horman <horms+renesas@verge.net.au>
>>>> Fixes: 9d16c4a10e07 ("arm64: dts: renesas: r8a77990: ebisu: Add backlight")
>>>
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>
>>>> --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
>>>> +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
>>>> @@ -191,7 +191,7 @@
>>>>                 clock-frequency = <24576000>;
>>>>         };
>>>>
>>>> -       reg_12p0v: regulator1 {
>>>> +       reg_12p0v: regulator2 {
>>>>                 compatible = "regulator-fixed";
>>>>                 regulator-name = "D12.0V";
>>>>                 regulator-min-microvolt = <12000000>;
>>>
>>> Perhaps the node name should get a more descriptive suffix
>>> (e.g. "regulator-12p0v"), like is already done for some of the other
>>> regulators?
>>
>> I think I would prefer that addressed in a follow-up patch.
> 
> Thanks for this patch.
> 
> I have now tested it and it looks good to me.
> I can now access eMMC as a block device.
> 
> Tested-by: Simon Horman <horms+renesas@verge.net.au>
> 
> I plan to apply this for v5.1 as the problem appears to
> be introduced in a patch queued-up for v5.1.

Thanks

> # dmesg | egrep "(ee160000.sd|mmc0|mmcblk0|backlight)"
> [    0.893760] pwm-backlight backlight: Linked as a consumer to regulator.3
> [    2.901953] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.2
> [    2.910262] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.1
> [    2.967591] renesas_sdhi_internal_dmac ee160000.sd: mmc0 base at 0xee160000 max clock rate 200 MHz
> [    3.049943] mmc0: new HS200 MMC card at address 0001
> [    3.055843] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB 
> [    3.064414] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
> [    3.074888] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
> [    3.081522] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB, chardev (243:0)
> 
> # dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 14.7343 s, 36.4 MB/s
> # dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 8.46809 s, 63.4 MB/s
> # dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
> 512+0 records in
> 512+0 records out
> 536870912 bytes (537 MB) copied, 14.6945 s, 36.5 MB/s

Seems a bit slow to me for an HS200 card :-)
Update your ATF, it has QoS updates for SDHI.

-- 
Best regards,
Marek Vasut

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
