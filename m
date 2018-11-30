Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EFFC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:10:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4147320673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VkX4rc0a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Kpm1+7KZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4147320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p1N9mE0WIdtN1ncsLMfsRiU7z+7a+PPOPNxnng/OJ2A=; b=VkX4rc0anJlBBn
	o0piD6obAWvuWfcMARlrK23E41OPBGYUDLIZLCTOCTv6cGBWgoOnLWuiLAL7TOjLXz2GEv0YoLGI/
	z4RPOp3PsjEi1BT0HRW9xEyJixA1TTPjEoPmk2S2e/LOmmsbD2T5w9nCWHDkUETofORz2BINPofnZ
	ag81DtaAHkFrMSBvJUDrN8eONhi1mN156baLijFS1Z1W3/2r+rXzzqCAuzkVSIiUb47/HWGAQTH0l
	Xgll0aDcwTEPkeqcP7QjIRRGJTONfCQgvJ2snA2m9YUvmmnVtFi+C+2kNvh7l3nxN2w+d0rCGhrtZ
	4r6e+NQk46rYLgFi+YhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsrr-0003mh-EV; Sat, 01 Dec 2018 00:10:43 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsen-0002Fj-D3
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:14 +0000
Received: by mail-lj1-x244.google.com with SMTP id 83-v6so6471584ljf.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3jtapr6f/tMT8ob060VINmW7ubbK1EZiLGgJusc/hP0=;
 b=Kpm1+7KZpLR7rdO+9YZpwgc0K1hrSZka8V2RHon/nuvd0AHtUirJ2NdlKFHlmBD13m
 qJdc5zqjlV7K15X5BeWMxXW/HyFPkKVbDEk+FmykG9n2SKjPne36MOrAKdDpTdnqFlRi
 ly481FSWDtwgAXt1qDJnJajDfsifP8PmiCQak1JSbOpvKQWSwIkJWC1CbRhhqbIEpd7/
 xL6fLbiW9qqA3jx1Swlr5w7uvP7DSw11BzNP8Y7IRfKAYlz2zsaZq/JL7P86HNpllwdF
 Wi+zVcaE3MdpvUghGyEFwW3DJaqSjzRMxczSvjq/2CaO610kFzZjvr/1db6/8KrBO8NH
 POhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3jtapr6f/tMT8ob060VINmW7ubbK1EZiLGgJusc/hP0=;
 b=XAUlhNTt+yy4ZscL2K07kd7uSIsKa1nPTVTqFU6Zq6Hs5NOxEq4/iu0IzWoTEt2GBU
 hgnyKrwKrKb+BiV0X90Dh4+y0N2u1VyKB+TpxJL+GKB4Xkfb30Vp3FlzfDR8FgdVQ5MP
 yRuhsN6yz4b/NBTLHNH23YpUF+lLd3V5Oz32KNZtF5ly1Wl5LMCyawdq+4hhrp4niqmi
 L9ktfYjbSF6MXLMOP5YefwbRWjpve7jDbVOtAs92p5NCuYxUNf0UAWvewosEGxsL8CXC
 0asn9A3gQli0emY7MFV5GKVYO3rcZK3JNoVQPrSJWynC73UVrVwNIASrf/1kpGEJRW9C
 6y2Q==
X-Gm-Message-State: AA+aEWaNUYZLhhdAv6TFvmhVnl3cnapUSzFqNte049MAhSHXDMTqqyac
 9O60vlInxi1rIUoIGiyPbRNeOm0l4KbY6w==
X-Google-Smtp-Source: AFSGD/XS7Co5M8kJZ6ObCr5/nwnEq8KZA+OqiFC9v83vl9HNz1BDlvYpPdJBpwouMwuWh16+JEh7Ww==
X-Received: by 2002:a2e:9017:: with SMTP id
 h23-v6mr4411112ljg.71.1543622223020; 
 Fri, 30 Nov 2018 15:57:03 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id a127sm1051422lfe.73.2018.11.30.15.57.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:02 -0800 (PST)
Date: Fri, 30 Nov 2018 15:19:17 -0800
From: Olof Johansson <olof@lixom.net>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ARM: dts: realview-pbx: Fix duplicate regulator nodes
Message-ID: <20181130231917.fvunplj47qrnysbv@localhost>
References: <20181130010547.24757-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130010547.24757-1-robh@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155713_445313_FA923135 
X-CRM114-Status: GOOD (  13.86  )
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
 arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 07:05:47PM -0600, Rob Herring wrote:
> There's a bug in dtc in checking for duplicate node names when there's
> another section (e.g. "/ { };"). In this case, skeleton.dtsi provides
> another section. Upon removal of skeleton.dtsi, the dtb fails to build
> due to a duplicate node 'fixedregulator@0'. As both nodes were pretty
> much the same 3.3V fixed regulator, it hasn't really mattered. Fix this
> by renaming the nodes to something unique. In the process, drop the
> unit-address which shouldn't be present wtihout reg property.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/boot/dts/arm-realview-pbx.dtsi | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to next/dt. Thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
