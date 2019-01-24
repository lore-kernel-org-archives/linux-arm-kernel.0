Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MISSING_HEADERS,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC84C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:53:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC092184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JvmDHR3U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ohmlinxelectronics-com.20150623.gappssmtp.com header.i=@ohmlinxelectronics-com.20150623.gappssmtp.com header.b="sc/QcFSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC092184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ohmlinxelectronics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=uKqVQUzHm3KHkhs4o3+k4oSCJyJUw025/Y6lhd93598=; b=Jvm
	DHR3UyG8N4ldaqUp7UeV2STyOUEhBgmC9exv1Ue10l7nh2HVLunTRr95ia6/+N/787nwx4ZFzIxPh
	KeHdD/rDXWY0Urm275Jw7cUvXF9zWj9snEkS/ADSp5Mh7RPHvtDrg3ShatzV+CK2frRseryWOb41w
	h0q7MMVabPcL9W1evlkUgkbQaezOnGLNDcO/Cw/xKXYs9dmeZKgYWRPsnW+0WP/nLwrOfyIS3oKBA
	vrfQ/LLQ1mBXWZTX4JLeTR56jNrIaSfi032nnBuPCiomalevQd/UxYk6IDKtA4OnAy4vQ2ezdhGog
	JR7XsMpom1excyzk9P6ABjNW3f5JCCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmV9H-0007jf-Pp; Thu, 24 Jan 2019 02:53:47 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmV9E-0007jG-Hr
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 02:53:46 +0000
Received: by mail-lj1-x242.google.com with SMTP id k15-v6so3856957ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 18:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ohmlinxelectronics-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:cc;
 bh=n6RtpWHA8V03ECowmNKLCRPul4C13va65Kvspu1U98s=;
 b=sc/QcFSfgqJcCJepc6ZnfMzlKPlay3k7gx+JiAT+muAy+eSBAzjTpKL183EWVbdHID
 eM6/itBQDj5qTl/aE0HkIFKfCQUQEov6uByXHtcmsGLFoUYlfcDH4uCd32Orhzy8LTrm
 oQzDT7Y+QntQTGRqkzZOAdlT885HJ2Lt97SoqSk38W1NYcljUMhM7EB2d3Pk+n5VtYf7
 C0v7Pk4RI2HbdRK09UHdLU+UoWtVCuc7VtASbFNddrl5Dl99DK4dTxaZrXTjpuIV3NMd
 582wwmtT9U3uK2upzCf9Zx1ffNh9znHkZsi0OnXKHeRVHuOOzeVyY45FDyV7Jrqr+MMw
 FZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:cc;
 bh=n6RtpWHA8V03ECowmNKLCRPul4C13va65Kvspu1U98s=;
 b=fQz1nIK7irRKIHKezegldOgm/hLHSgM4hv6GIVpNTmIcc+W49oGdrduEYl7zzdA5IE
 mPFGOM/NPfiWLricl/HaI6bJc0LXqn0kHfxBzRkk+Yn5LrD6PlNj3SNlpv/spr9dO1bo
 mDpur0o1mid1A4uKNKPZnNZvRG+jqFwK2WUUrMquNT0CgknONFFo9h9NhGIOkOsrTO8f
 BfnZFXwaf2dJjLzzaoWci5bhRtINPOsBgMcDxj2yUnBTJuwSwXEsZjDbvAZnBypE7cYj
 1FReuyMKiaf6c2H+xgrYIxjoMIIyid5Z8ZUqgIbttd7IE8G3Lr8oYzxSKe+KfeGxxTjs
 /9bw==
X-Gm-Message-State: AJcUukdbjRfILBefgfBLOO2NBZkFnqzjjwS8MFHjF2wp5+wm+TZVW7uY
 HDVov0NpLoZV+/PbxvtMpDB5AhxziFL0/GoUZALZuw==
X-Received: by 2002:a2e:6595:: with SMTP id
 e21-v6mt2825530ljf.123.1548298421079; 
 Wed, 23 Jan 2019 18:53:41 -0800 (PST)
MIME-Version: 1.0
From: Ken Sloat <ken.sloat@ohmlinxelectronics.com>
Date: Wed, 23 Jan 2019 21:53:30 -0500
Message-ID: <CAPo_4QDW0r22ZTqtS_NDFWB3NFLBx9YEGgWKb-P9A3t_TBAFMQ@mail.gmail.com>
Subject: devicetree: media: Documentation of Bt.656 Bus DT bindings
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_185345_007506_11B15BB4 
X-CRM114-Status: UNSURE (   7.46  )
X-CRM114-Notice: Please train this message.
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
Cc: mark.rutland@arm.com, laurent.pinchart@ideasonboard.com,
 maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
 kieran.bingham@ideasonboard.com,
 Nate Drude <nate.drude@ohmlinxelectronics.com>, wens@csie.org,
 robh+dt@kernel.org, Ken Sloat <Ken.sloat@ohmlinxelectronics.com>,
 yong.deng@magewell.com, jean-michel.hautbois@vodalys.com, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are a number of v4l2 subdevices in the kernel that support a
Bt.656 bus also known as "embedded sync." Previously in older versions
of the kernel (and in the current 4.14 LTS kernel), the standard way
to enable this in device tree on a parallel bus was to simply omit all
hysync and vsync flags.

During some other kernel development I was doing, it was brought to my
attention that there is now a standard defined binding in
"video-interfaces.txt" called "bus-type" that should be used in order
to enable Bt.656 mode. While omitting the flags still appears to work
because of other assumptions made in v4l2-fwnode driver, this method
is now outdated and improper.

However, I have noticed that several dt binding docs have not been
updated to reflect this change and still reference the old method:

Documentation/devicetree/bindings/media/sun6i-csi.txt
/* If hsync-active/vsync-active are missing,
   embedded BT.656 sync is used */

Documentation/devicetree/bindings/media/i2c/tvp5150.txt
"If none of hsync-active, vsync-active and field-even-active is specified,
the endpoint is assumed to use embedded BT.656 synchronization."

Documentation/devicetree/bindings/media/i2c/adv7604.txt
"If none of hsync-active, vsync-active and pclk-sample is specified the
  endpoint will use embedded BT.656 synchronization."

and amazingly even
Documentation/devicetree/bindings/media/video-interfaces.txt in one of
the code snippets
/* If hsync-active/vsync-active are missing,
   embedded BT.656 sync is used */

In order to avoid future confusion in the matter and ensure that the
proper bindings are used, I am proposing submitting patches to update
these docs to at minimum remove these statements and maybe even adding
additional comments specifying the optional property and value for
Bt.656 where missing. I wanted to open a discussion here first before
doing this though. Thoughts?

Thanks,
Ken Sloat

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
