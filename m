Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E75EC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32A4222B5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AW9EDEgK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOBXau6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32A4222B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4GN1Y8w35NW7YRkuy/npZOlYUx0jOIwY6iws5Z94YFY=; b=AW9EDEgKj3QeTXcClLOOIAtCe
	EDTv8kfc5WSgeFb+2Fw8EFJ0YH/R7JBysx+behloqKR04azKdD1VNniulZl5eoLQs4xkh9Yoc7bB8
	rL8m0qeq4u9L05kr436WgI3ex6dQ/JLiUCf0+UCdr+mAhvqSpnejuAFjZfu12OuLLiSNTQBOWXxwP
	E/O+PYwhncR6xcKtV9p3q4hEHy84kKVKBuH5R6UnMKHPYr3UoEM4ICV2WAydBoSmKwKmr9tRLBaqP
	RwcSKNa1gqz2nOsKKtTOdi4uR4IhVLOCPju/qwdOX0Ltnsq/+YTPW0zhvxxnAYxY8JKPFcwz9TL49
	ze55RiY4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtpZx-0000al-Bk; Wed, 13 Feb 2019 08:07:37 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtpZu-0000XW-B4
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 08:07:35 +0000
Received: by mail-lf1-x142.google.com with SMTP id e27so1048037lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 00:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fHcGxz3V88oGQhykUNeVVZN70O0EhRcnJWcib7mocSQ=;
 b=UOBXau6BHAsTofr53bBkRVeGAvV1PEfVNhteIEGtw+aslAiL+Jf9oxf2HHlT/OEU2q
 NACA9f4jjzyFACtO0GRcnMgSH3/QzQtivCAN4zcYuNCFD5IY7DYfIS+FcMYuA/6bUERy
 Gyfqn+vRGIPJISsXCPKtNi7hR/6/T5D4hrA/xBwDd3810fGzFlxM4TpyLh771uMx+47G
 A2MBaeTU7SKAiZHuFt8zw2dBElWQMp3PEBA3mDL74dIZ9n4H/SnpjyKvPmCCw+oC7+hX
 E6zY94HLyWD+xXQVSo6EMTVKCzdlo7C2buQbS56+YxE84/UAS6+COxst8znFGJUY33XW
 NSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fHcGxz3V88oGQhykUNeVVZN70O0EhRcnJWcib7mocSQ=;
 b=VvyCj+5SOq9cpaNiBEKR0XaFaCWnSayd6HZ5Nm3PCgp1khvnj5mtXrtHq2BHRsl3r4
 2paYO6A0JBL2+XkUsXSn5pqNGd10VxgbqFYm81aXlpa+dVZ1lHHbLmr1rj/qrDzVAD6L
 gdyJ46A7qcmff418FbdN5qLUzhSGOOpm0QcV4nKp63UFP+/fHFCjbSq3/4+f1GBzpwM/
 qy73qw4SP77Drzohh3d1XgZVp7y2Fj5rftQvY5LgZAQof5FPEL2mfth9i/5BQ93K4Jn2
 ycOS8SZIwZ0WpV+X+XfX5SiRa1o+nhxN1ZFuF0YetGKx49MpVIkwv75YNfwkY4PpCoIG
 qnRA==
X-Gm-Message-State: AHQUAuaKequBDAVOEymR+eihqi1HLmygqIho5GCxOStBlmpCr42lGeF2
 ZyP/lid7yKoY7qx3w06a5kA=
X-Google-Smtp-Source: AHgI3IboGuxbtt9iiv1hzDd81tncWimgZmURt+jqYk3xvLsEz6vypmyIEokNA4W9pziLbtUOepP2yQ==
X-Received: by 2002:a19:914c:: with SMTP id y12mr870894lfj.55.1550045251623;
 Wed, 13 Feb 2019 00:07:31 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl.
 [194.187.74.233])
 by smtp.googlemail.com with ESMTPSA id z17sm3902977lfh.9.2019.02.13.00.07.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 00:07:30 -0800 (PST)
Subject: Re: [PATCH] ARM: dts: BCM5301X: Change Ethernet switch management port
To: Florian Fainelli <f.fainelli@gmail.com>,
 linux-arm-kernel@lists.infradead.org
References: <20190213042600.27729-1-f.fainelli@gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <43f75739-b592-35d3-e711-13f05218133d@gmail.com>
Date: Wed, 13 Feb 2019 09:07:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213042600.27729-1-f.fainelli@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_000734_423026_E69688D1 
X-CRM114-Status: GOOD (  20.58  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM5301X ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13.02.2019 05:25, Florian Fainelli wrote:
> BCM5301X has 3 Ethernet controllers: GMAC0, 1, 2 which map to ports 5, 7
> and 8 respectively of the internal switch. Future changes will turn on
> management mode in the Ethernet switch driver (b53) which will require
> us to use port 8.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> index 3fced3b7f1a8..affa9cc7422d 100644
> --- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> +++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> @@ -150,10 +150,15 @@
>   			label = "wan";
>   		};
>   
> -		port@5 {
> -			reg = <5>;
> +		port@8 {
> +			reg = <8>;
>   			label = "cpu";
> -			ethernet = <&gmac0>;
> +			ethernet = <&gmac2>;
> +
> +			fixed-link {
> +				speed = <1000>;
> +				full-duplex;
> +			};
>   		};
>   	};
>   };

I'm not exactly sure how Linux switch driver works, but from DT
perspective I think we should rather have *hardware* described instead
of a common Linux case.

If I'm right, we should rather have all 3 switch ports described (5, 7,
8) and have Linux just use the one it needs.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
