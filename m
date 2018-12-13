Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7722EC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456192080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MHfL4wTz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="L7MOSdzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456192080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D9Fxct68eYSBOEvlMcLXLTUfPRHb2PiVR9b09hSZL/8=; b=MHfL4wTz+Da7l1
	/XFR5NlbOWP8lx6/16kX7DTAxtjm8Cjn5X1NsOZ8gHWF3EcymgWq4WNEP1V3hxcej0s5cJ64WARdj
	89Q6w7ycYHGu3g50C3+1n34rvgHtcRmS15eMwXhZiQyAKlWcgTbHrcStf/X94Hp6M2Je8wRk6UZu4
	LykFw3pITQZV6YM2evhK2zKzA5ydhykL9IA1lKQBUN9yT0ObvZNFDwlOdRZ1x7Dy3hWk5NXVxIoE/
	U7NrczMqb40dfEhSuD/17y2I7VmZ4kEDCmoapJ20YWCg2w2oLEG4FWVinwCqriQoHD+0nXUMgTIoN
	2VkGIa1r9iQ6SUEC5V7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXKqg-0004Fv-3c; Thu, 13 Dec 2018 06:51:54 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXKqR-00045d-KB
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 06:51:41 +0000
Received: by mail-lj1-x244.google.com with SMTP id s5-v6so759773ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 22:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AJrggUJM9HyRlJ9RZduko0OXl6m94GDAOUHtfdtlTaI=;
 b=L7MOSdzSpci07saepHTj/G6h8ChTaqpt8rBDu0KVKPEOtg++x1y+z81cueVg5RpKqZ
 AvCU2QfAQAt8WLvqE+N1JvvxrcWSluzkzZza+YNpBAxC7EM7dRkraRNz3hIV2At50ala
 sbVbnQr82KX0H7SBzkoZXa+B+E87664F9IkrYPCgIcW5oYn5ydl1Tj/BJ4ZSaJjlie4+
 NhAMPqlZYmmQtxHuFE6ZpyWEWx041tfutPDrGBmkBwN2TwvJYdxSAf1dHYnLda1VC3ti
 CNcR5woaxD2NXGLziNY+MEvMJGZSSj3hSAi/CfPRz1mK1RSItZMyZ0wO/Wys/j4N5Pi0
 wA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AJrggUJM9HyRlJ9RZduko0OXl6m94GDAOUHtfdtlTaI=;
 b=ph2SU1Ncu26vHmxL73tS4WtZR5B8BoFns8vw93Axi0LlQx7lkcAtkwbIxkmGRTwDgZ
 ll4Hb7zw62onaAzpjruIvWOroPsl5xSaT6YV595RRsXy9UVXhy+wCWLRLBPhK9YrAxAD
 Gye4DeUe9853ycmDysYS/PHWOxT1467RusGhWatCf10fBrk0kF5QJRK9nck4jzFN0ybn
 i4+YzTHsOaGUps//lwKnh8SOS/xkXHl1ZswLrGJt09DmY8yL6ViwLGF2mzDoCX1o3lbY
 AgTD1r3+JFRjBtSAA9ElodFhC+iXs9KbKYx4Bdf4iqAMJRxCWxsdfzqyFMzzd5gp0Rkm
 YDEg==
X-Gm-Message-State: AA+aEWZhNVem8heun8rWJv2yFTHITLVMcvmclpTdCW6U4VFdth5pPrny
 Z0dkpaCPfz4JDwmNAq67WMOevA==
X-Google-Smtp-Source: AFSGD/WACcSR0S+vuJGTwPBupwzkY1H6lTzsmuDsUZIkwEZaThISHdAIOkBsYwgpKILjQmB6CNZntQ==
X-Received: by 2002:a2e:9b15:: with SMTP id
 u21-v6mr13554544lji.29.1544683891988; 
 Wed, 12 Dec 2018 22:51:31 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id 1-v6sm144892lju.61.2018.12.12.22.51.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 22:51:30 -0800 (PST)
Date: Wed, 12 Dec 2018 18:09:50 -0800
From: Olof Johansson <olof@lixom.net>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v3 3/9] arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
Message-ID: <20181213020950.42zjgd2ime4q5olw@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <189efc09-0863-11b5-2983-f27530176307@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <189efc09-0863-11b5-2983-f27530176307@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_225139_766704_05CBF5B0 
X-CRM114-Status: UNSURE (   9.29  )
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
Cc: arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 09, 2018 at 02:01:13AM +0100, Marc Gonzalez wrote:
> Commit a0ae2562c6c4 ("netfilter: conntrack: remove l3proto abstraction")
> folded NF_CONNTRACK_IPV4 and NF_CONNTRACK_IPV6 into NF_CONNTRACK.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Same here, this one is no longer needed either.

-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
