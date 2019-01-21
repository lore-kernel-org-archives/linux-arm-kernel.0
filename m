Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E03C31D64
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 05:02:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3488D20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 05:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="phLjpWzg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/hi7yRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3488D20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wAlD+GjLCwZxjtJi9XPw+Tf7bVQpYc2aPOzFMNI+KvU=; b=phLjpWzgrMwby5
	TNOqoK/G7KsRG0XgsBSQjdHPJJ5L6xLru5FhISMiOu/rQX29nUjiHJtv/kB2O+ZKM1JJYXa6CETSa
	WADcNggBlSp86Y4jefeGwo4CLctgbDxn2ijnecfkhwQOl1d4//n+gjGdVM0Hn5ki4RigxeZSUYSkw
	j6Fp9tXeleBYbT443iqSuuvdyadSHreXGn4gAi3IAuMfQOEbJc8MjVrlcRcWL9QvxIINnLqtjQjPc
	bDJ+nBIDJpuTqsBr9nVoZNnR7LuU5usloQDWrAgYWck2KprG8+ZxdTqb/3E8dOQWe5YOYXrr4UENL
	PO+CJ7CaIykOkJKfG3vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glRjT-0000v8-0p; Mon, 21 Jan 2019 05:02:47 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glRjQ-0000uh-9P; Mon, 21 Jan 2019 05:02:45 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so9429788wmd.2;
 Sun, 20 Jan 2019 21:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UcWV0PdeaSDvdUuhmGQO4m2BfscklrgYjqBuY12PCcA=;
 b=V/hi7yRPHDsMVi+58AG/7kkBZ9xNbfET9mbQLBX3rRa/5S7Egazzo7GkKx9Nr9QDNn
 Q15Sqj+UYvWVPxZ1iDrs0zmGFl/j92dU/1HkPmW+NvEgq+ZKIZc6fAcJG2EkTDwBwcsM
 0tR9lyaa4UUNEeXocry5NDuP4u54NiPNk3osDNj8tPXwyLvLWz5h90/XHbYLjTjd/uxv
 5Npm5bYTyDSigjoqWT6ENgMt51nfhoUtFMdiBrTg1FaE2PQxZhX0uiK8nhovLCKpIe/f
 FRdh8srEegnbnGPAi/ZqyLfmizy0R1J9rQnjL980El8d5/mqH/mS7xs1Mnsg9lephuzG
 RQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UcWV0PdeaSDvdUuhmGQO4m2BfscklrgYjqBuY12PCcA=;
 b=uG67aIX/An6YsqLcsiYHDkW3zw2laoTde4Ig/24Z35/rRR85LLZa9dsn83skpCPtR0
 q4smwd1xQflqB6BBDH8lWiH/T/j4M8tngPdlqfPnm+Hv29ueGRO11PCwrBMwpLWOlXie
 iBSLjL65m6duSQeUabObv3x5J9Upz3NRBCkhk4njwXR5qVAMzrZk29KJLrKTEMUbLp06
 7lJVavqJWRowu/OQV7keFGeaK3QF0ILAE/rO8KOm8FSfkvxR1ZZJ/Gdmwz1A9HYHpwFI
 crbkf7UW8Vy5vy5/nZGZ2e0SzWdHwhBmU7mLR5eXpLa/AR1cQfxDJ5VPOLoPUr0CtQ9B
 PTyQ==
X-Gm-Message-State: AJcUuke5peKOJU36AqIxo1Pe/fnt9TDNWJnhJKI73k/L0xkpc4PafjPl
 HzIjUVr9XhLeUlT/6hU+afcjYtHXvUqO1uWRleg=
X-Google-Smtp-Source: ALg8bN6K+iAUk6mF3Co0mH09IW0ow+csSdwV5X0wpG9aRMTsDgPPVKdvALpgEFCoSOGajbqnfpj23G0R4C7Opg9j9eg=
X-Received: by 2002:a1c:8acd:: with SMTP id
 m196mr23428779wmd.120.1548046962976; 
 Sun, 20 Jan 2019 21:02:42 -0800 (PST)
MIME-Version: 1.0
References: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
 <1547297008-2740-5-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1547297008-2740-5-git-send-email-stefan.wahren@i2se.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Jan 2019 05:02:31 +0000
Message-ID: <CALeDE9Me+dzsdwvmGNMO2SKQoLot_7HEshYaa15=5j04jZCbnA@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: dts: bcm2837-rpi-3-b: Use consistent label for
 HDMI hotplug
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_210244_331148_5E425209 
X-CRM114-Status: GOOD (  16.63  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Gottfried Haider <gottfried.haider@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 devicetree@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>,
 Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 12, 2019 at 12:44 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> This make the GPIO label for HDMI hotplug more consistent to the other
> boards.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Verified output on a RPi3.

> ---
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> index 9abb9c5..31b1c03 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> @@ -39,7 +39,7 @@
>                                   "WL_ON",
>                                   "STATUS_LED",
>                                   "LAN_RUN",
> -                                 "HPD_N",
> +                                 "HDMI_HPD_N",
>                                   "CAM_GPIO0",
>                                   "CAM_GPIO1",
>                                   "PWR_LOW_N";
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
