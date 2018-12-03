Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751FCC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:06:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474AA2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KYKvGZAG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UctLZlsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474AA2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vDVtV42LuMrI4iFWDwXf0w9B9tsZRQD/HdJSGzQZwVM=; b=KYKvGZAGQMNZVc
	fj8u68NRcW2MMHKN9FPbF4C+Cd6V13uHxLiQt2LQuEUcUd9Q2FqF0iHXc5imje74I1EdnlASOE596
	xFae+xCkwpwHI0QiB/+AUbL5sOULg2GnfOTrIrVPQLSkdPqSYIXTTDqfu03a7LNM7Asb42uR97QQo
	lH8boyh/nLoJZxrPTAHvQhhNF8x8Bx5L6UCmjm6GyIl+Y2HkniOVL+aqs9KjEEFypzgOf5p9dof4s
	B6kumqWpwfbgtuGMg0h/rDrgFR29t0Y+k/O5B/kpA2uTRtDoHLK21iWSDoGfnWnEcy6QSO8E+/9VY
	02DZ2W4s+rJmOi2rY1ww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTxIS-0008KO-2Z; Mon, 03 Dec 2018 23:06:36 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTxIO-0008Jj-VA
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 23:06:34 +0000
Received: by mail-ot1-x343.google.com with SMTP id 40so13351470oth.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 15:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sLK/cE7G66zM1vPuYLGYNcSa0cxIKTFUPJVLQ3Rmm4s=;
 b=UctLZlsCFYUqk07WxIFHUa7RWheo3GvCtCq1FGsV5nMCyT3+CzoiiLYIHcY4eBR61r
 KFEeh1q3kAAgZCtmZPXsaFVt0VZ6KjHN3OYYeP2wg7Ful7jkjcsHNtjsCeoZLPlr5Rr8
 uDbi5iOIoIjieStIfA2XTO6BZtYAiHC4fY7cROf8Dnyf9FgX2Uynpq199nY30D6bmf2x
 u7SYVyq1PBqLwv9xNNKEjtD4Eo8JdKXyJekGSpY3bK6+Y8U6L18FjMU6aRNw9H9r2rjF
 MrYJmqGsUBBziY4lZSvXGJKJrq5njxXzJeJiwGd0JCYm7ly9VDpZOJrwIqZFOxDUHRKy
 EBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sLK/cE7G66zM1vPuYLGYNcSa0cxIKTFUPJVLQ3Rmm4s=;
 b=gUxY63oNx8zbj1t/t+S3FeTZK1Ip2qM3GRf4mb2vHFPSwL6mRovQ7xis2Lw4GTDn64
 QXOlyUOPMqpG5TnBPOtLyv+A9CPp9GWGf6Rd6Ssc7TCVeEwPy3qwC1TsucbTskZ6rQMD
 ZbIjcXrDm3YSDa5dv9ynaTwcrO4WPnSRCgCenl6dRwpc3uclSq4NobYyA2JdVHEyub7c
 ySawK+zRqhyks3/BT/M9fx8GyZ5oVwxWl8Qf8rh8VRpOSGZf1iJ0qbLmftKFgC32qwYo
 UPcvsZhiSLT60sTALYVAVTRN0lM5yUF65PeJ0YVh1AXHTrR9VjViscAQBOR4YjJO5u/E
 seMA==
X-Gm-Message-State: AA+aEWZIbFpPgG4sRxMgG8m6eo3ltHVMF38hZCyPeZyb0EX44jbPR+VH
 3GaN0qCC3ip/sbazSIgHMrWeCF+om6XLV5mrBfgIlg==
X-Google-Smtp-Source: AFSGD/WeDmh7oDdzD+hm52jNYCNad+kPyeCuFXj1dDIkGp3t18/9mpbsjMEIZvWLibfBoPk/xfwe3ipkcjmqGNnmEys=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr12365206otp.225.1543878380553; 
 Mon, 03 Dec 2018 15:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20181203211816.5129-1-jonathan@marek.ca>
 <20181203211816.5129-4-jonathan@marek.ca>
 <CAOMZO5B18DyZ0zvit6AgaueMifnMf2ctSo7pE_XndRpt7+bnLw@mail.gmail.com>
 <3e8d1f9e-ffb4-dd6a-0a68-f59b4c1134a0@marek.ca>
In-Reply-To: <3e8d1f9e-ffb4-dd6a-0a68-f59b4c1134a0@marek.ca>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 3 Dec 2018 21:06:22 -0200
Message-ID: <CAOMZO5BAPATbQGpdnjud29gVA2uDH8xJp0UVK+P88DF4PFJi6Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: imx5: add gpu nodes
To: jonathan@marek.ca
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_150633_008017_78D11482 
X-CRM114-Status: GOOD (  11.11  )
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
 <devicetree@vger.kernel.org>, freedreno@lists.freedesktop.org,
 Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Chris Healy <Chris.Healy@zii.aero>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 8:24 PM Jonathan marek <jonathan@marek.ca> wrote:

> > I can't find the dt-bindings for these compatible entries. Have you
> > documented them?
> >
>
> It is the same as qcom,adreno which is documented here:
>
> Documentation/devicetree/bindings/display/msm/gpu.txt
>
> I guess I should add amd,imageon there.

Yes, please.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
