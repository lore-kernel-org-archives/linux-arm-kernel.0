Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D44C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:44:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 339C620666
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ENKz/teA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XA4140bC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339C620666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nt8tBfR06JkpXR+VQxdj55Eb4GQdeuzvqIYiSma2lyo=; b=ENKz/teAs5ywR/
	I+9z7xpd4Dz5e8lbPkNVdIxigABsTi596CsFBRipvpTsG7RfypOnP7qE8APRDDFta5JrdEn8tHYGH
	7/v8AEmB98PRbycSOV0CUNILx6RjfQ4sDmQzmQg6F/2YqRybXsgJt7RlczexJpZPUVent3FTB9+eD
	V8is0DKopA270ox4GHvJn8EOFzvwm3LEFbS5d2ThElnJCH46TdzFaJv2NdlLsK5DrEpD1vSoV7BhK
	6Y+2fL2TyQFNvClL+z0gJzoZ8N2bPko2hz5E8ovxObyQP5m2ypqvPhRjZ8qlIEFxsDdsG+EXxWlQ9
	O5hSrXVZ/ix0tLRBxGAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTkmS-0006Kb-LN; Mon, 03 Dec 2018 09:44:44 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTkmQ-0006Jj-9e
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 09:44:43 +0000
Received: by mail-it1-x142.google.com with SMTP id g85so8210142ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 01:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3Oo32VVsYmPry9+f8DWOR0NGFz2f9fT3cn4yoPNUDcc=;
 b=XA4140bC2ZxcXC2xZ64Iosuza5gH5DtORINToSnfBNJaWMxYt+DAobBRiVkZNi+oPM
 Y/8NZfj6bbDOSPCGIklwiP6ssjlL55lvux56S9EudA1VIz/yd2sjnEZ6ocDGLHy6+icC
 WLe52JhpKZGdGImq2bmpfuLFr5eWHTy/z30Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3Oo32VVsYmPry9+f8DWOR0NGFz2f9fT3cn4yoPNUDcc=;
 b=G3o3C/vAf8BPcosewyDNv2v/FAjZBt8aiAZRRiur/ebeEqlxUROvgw8Mw2zQMmxQ6h
 Czm7JWZuHO2gjIyO+hP8xAFb38CkQLDWL4Bzr5y6XovMw8pQjWOExMP+mJuoFgarjQpx
 0a8/hOYojzt3RBju2pkrblB5KILXcQ2vMap6okMLBLthT+LqqYBjsj+aoYF0thdzrfF8
 gpqFWPvXkvDn2eS72nz4BqkWIILGJc1wGfn7uipzl5kUNoms3V5eCczmn1kM1CV3a+Mi
 /QLgIw53UmT5ZgkQ/J+nrvQ/arCLlw0OB2TbsYZf0TLug7zOL2RUeS8keh14xDiedBgu
 2KSg==
X-Gm-Message-State: AA+aEWY9cVA8UoVuWTtEAU8e/4hptF/dxMjtiQs4WO4+cGxMz+6meM6d
 XI4ym63ZjiShSK7cA5q/Fa1nNW2FqTmVJgNGBXCSbA==
X-Google-Smtp-Source: AFSGD/VQJciOD7xP2xny6eLLvKTKU4UajB7IpGIr6GX9LxJ5o08UYNknI30r5ACp9rbcberi1/Nr8XIB+iKuo0mtfx0=
X-Received: by 2002:a24:5411:: with SMTP id t17mr6871416ita.32.1543830270402; 
 Mon, 03 Dec 2018 01:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org>
 <20181130075849.16941-4-wens@csie.org>
In-Reply-To: <20181130075849.16941-4-wens@csie.org>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 3 Dec 2018 15:14:19 +0530
Message-ID: <CAMty3ZBFVStHNbYaBxT+Rmy6+g4jtm0cFKk8BL5BDid3c5VW-Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] ARM: dts: sunxi: h3/h5: Drop A31 fallback compatible
 for CSI controller
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_014442_335528_7ABA6969 
X-CRM114-Status: GOOD (  12.46  )
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
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> The CSI controller found on the H3 (and H5) is a reduced version of the
> one found on the A31. It only has 1 channel, instead of 4 channels for
> time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
> "fallback" to a compatible that implements more features than it
> supports.
>
> Drop the A31 fallback compatible.
>
> Fixes: f89120b6f554 ("ARM: dts: sun8i: Add the H3/H5 CSI controller")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
