Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229CCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:43:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FB52192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qB8MrZOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FB52192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BnA4Z9yWA5yP8Mtq5EsOPOE7Xi0SejdbCyn7KN36X5w=; b=qB8MrZOD/dPp+M
	ijWAovDa0NtjC2SQkdFs9TYN2HjeAQSTXWrINik+0hiPPqG1WUNTsIUQZD+S4ROEaRS/4CO4glF2C
	yubZkdzc+oSWVUMhUeTLoX/IHJLPEU4VObwZjSnMpGy3Pk6ihJD4HHvEvuvQmFQg72HSsNBSIzLgR
	EruzwA3HMEcrYdhv9RaV8qcd02MqGtSjWD9afgJWF7hRoAkr7ededqRnUCzi9n2aY5FlwMHS1/jKn
	a7YH8UBSsy2lrXseVyLjn1JBmtEtNlER92JVgzziP1DLDduiBydCAmOtUmMw5/fN3F0kMKzrtnb06
	GEfcDohPCBW3gizhMn/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufee-0007yo-Qc; Fri, 15 Feb 2019 15:43:56 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufec-0007yM-6P
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:43:55 +0000
Received: by mail-qt1-f194.google.com with SMTP id y20so11245969qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pvbqqwZCSlZj94ijWSBgj81ysEPNf8u1cl1PvRDX/Rs=;
 b=sr27JT25qyQtsDdz9tglW7IWLeIGv7HNabPty+BPjaqXoXzXIgp/dmpcNNLJRy8aQu
 p/aa1eu3FgaSWVLBodyiB595zcJ3/Yt8dwUfYAWUj3wjoBqDC+VXSzrdoSdUQYG0ywcx
 H6hMjT1z+BL3ZvgUUVve6o9AzcP7PkQT5+TX03CEKL/CanQfsrqZCg8F1Ebjd5kR41r+
 c/9tbD0DXGAW7av3JalZFAYQI2kWmdvT/wYEAe+c9zBZLEfkIWKsQ5rUweO2iLbO05BQ
 2x0+wlydzB20fJBclNur1iFWDbj+sQllCAdWvsdsb3smx6c/ecAsEHIAXp0AnHuh0TkY
 5CNg==
X-Gm-Message-State: AHQUAuZ1xbG8mswIYig1n7kFG2umJTnbwPoocBgrh+kt8N28Vp9Vb2iq
 NdtvJzo4D3UoG2omp7CbCDRXI00dqwrM0ZLJUqMP1LiV
X-Google-Smtp-Source: AHgI3IZ4AEJPT0WGlhdnmLKJcZFSYRK9BZO3JmRLRtNZxNOi2XMYiiW62jxJi2y8v28+ENinj+lcOFc//ovAc8WlsHE=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr7969009qtn.212.1550245433330; 
 Fri, 15 Feb 2019 07:43:53 -0800 (PST)
MIME-Version: 1.0
References: <pull-1550167958-188990@atomide.com>
 <pull-1550167958-188990@atomide.com-2>
 <CAK8P3a0y5FYYOvqPqhDSmR1Jxgx3AJzHtEkuku+_s-1vV_a8Lg@mail.gmail.com>
In-Reply-To: <CAK8P3a0y5FYYOvqPqhDSmR1Jxgx3AJzHtEkuku+_s-1vV_a8Lg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:43:37 +0100
Message-ID: <CAK8P3a0kZhJppsFzaTZL+PVCDP8BHwiquF6et3=i6MwA8YNpAg@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] more dts changes for omaps for v5.1
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_074354_228937_253A859E 
X-CRM114-Status: GOOD (  15.66  )
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 4:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 14, 2019 at 7:13 PM Tony Lindgren <tony@atomide.com> wrote:
> >
> > From: "Tony Lindgren" <tony@atomide.com>
> >
> > The following changes since commit b4c30df0eb354d8e081132b7b7449f6d17619614:
> >
> >   ARM: dts: omap4-sdp: Make ethernet working even if booted with latest u-boot (2019-01-24 08:23:43 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/dt-pt2-signed
> >
> > for you to fetch changes up to 947b7802597106dcbef2ddca23d386f9339ba334:
> >
> >   ARM: dts: omap3-gta04: declare backlight in lcd node (2019-02-12 10:52:25 -0800)
> >
> > ----------------------------------------------------------------
> > More dts changes for omaps
> >
> > We add support for Bosch Guardian am335x device, and configure more
> > devices like GNSS and LCD backlight for omap3-gta04. And we replace
> > the wlcore binding documentation URL with a local file that we have.
>
> Pulled into arm/dt, thanks!
>

During routine checks, I came across these gta04 warnings:

../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
(graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
node unit address error, expected "0"
../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
(graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
node unit address error, expected "0"
../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
(graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
node unit address error, expected "0"
../arch/arm/boot/dts/omap3-gta04.dtsi:757.7-764.4: Warning
(graph_port): /ocp@68000000/dss@48050000/encoder@48050c00/port: graph
node unit address error, expected "0"

Can you have a look and send a fix?

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
