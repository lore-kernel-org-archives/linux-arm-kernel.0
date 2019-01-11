Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ACDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:29:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECEF218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AuTcV8rv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECEF218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=syFThODd1Y4vd0QDqwZLa125lzRgV3PakLU7gM12PRg=; b=AuTcV8rvfl9rSd
	T/LzLDVMde7Ryd0w4phOUhKu1QTK8jYTWJO+x9hsvD6j/iv33DuQafUW8GLBXAStRNdQEQHk1T9/3
	dRpvFnjFgM6d3qcoKTh9YAqy9fSVJvN8rVCU7aeq4wmNESSpyy2MbFOilEPfvXTsfbOPpU/r/cUz4
	fq7Z5HeX+l6GyZiNzwOEYwopIG98d5NuPVgn2sCuU6cHR0UTVyW3HKjEluUU3MlIbept3PkLIqSUI
	JCvh3DJSqCq0yZNEV65l3hGijvhCDUbXpqxSrNGqyJAdWlDHrDp0ZnT/NzpoNviWmJArIIJ6NV19b
	4+lR0sNtrKeUt6aSnDug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2Uc-0005Mr-8K; Fri, 11 Jan 2019 19:29:22 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2UY-0005M9-AZ; Fri, 11 Jan 2019 19:29:19 +0000
Received: by mail-ot1-f65.google.com with SMTP id s13so5614679otq.4;
 Fri, 11 Jan 2019 11:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2BYGI3XUbtBip/6Pn/WEr4+G6mRxfAk9QGOSRGink9Y=;
 b=O+kYx60M42rMo9UWlXZeUYc1O3jSQAEBxhKzQ2F9St5rkUOk0+AxVHmh7Cjg7Lmgo+
 reFmbbZvgqgb5WVtCfQBuO8B+pygkLuxuT5hu4+9sT0ROTODZD0KOjrcYZbP9xtRyopV
 Hmj+fF/Cno8dQdvqvIbrKjQQaSNm/snYEH8B0ZSdpKSzrSqiY5hZvH+8oxZdnqsgs4RJ
 W/ZBXuG9fLT1vA972PKMPC5oOmrIdCMafMPhTrfiwVoopfK7m+pVUcaepLc+ZmbzITd3
 JE9EbS48VUPuLCXbFRWZuxIVJhWTzAb2xN/EBwY0dI4E4HGpMkL2oKuwaLaRGfHWU4Rb
 3stw==
X-Gm-Message-State: AJcUukcULDYvINpRDrcjsPIf7aurw1GcXoBzuDXCXnFy1yA1GXNpvufb
 NyyjPhIwAcXw/tVHfRqMFQ==
X-Google-Smtp-Source: ALg8bN5BGZe9LUOzfOQYm8VHEkroqdYpR9RuD8DNGh1mm/RZr+lc87sQx0Z60/lSxEOg+0felT4W/w==
X-Received: by 2002:a9d:3e16:: with SMTP id a22mr7685269otd.43.1547234956992; 
 Fri, 11 Jan 2019 11:29:16 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s66sm81941600oia.55.2019.01.11.11.29.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 11:29:16 -0800 (PST)
Date: Fri, 11 Jan 2019 13:29:15 -0600
From: Rob Herring <robh@kernel.org>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH 4/4] ARM: dts: rv1108: Add support for rv1108-elgin-r1
 board
Message-ID: <20190111192915.GA17772@bogus>
References: <20190104014023.17973-1-otavio@ossystems.com.br>
 <20190104014023.17973-4-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190104014023.17973-4-otavio@ossystems.com.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_112918_413293_75CB5817 
X-CRM114-Status: GOOD (  11.66  )
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
Cc: Jason Zhu <jason.zhu@rock-chips.com>, devicetree@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, Otavio Salvador <otavio@ossystems.com.br>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Vicent Chi <vicent.chi@rock-chips.com>, Olof Johansson <olof@lixom.net>,
 Andy Yan <andy.yan@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>,
 Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu,  3 Jan 2019 23:40:23 -0200, Otavio Salvador wrote:
> rv1108-elgin-r1 board is based on Rockchip RV1108 SoC.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/rv1108-elgin-r1.dts         | 206 ++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rv1108-elgin-r1.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
