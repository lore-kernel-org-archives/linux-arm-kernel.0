Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6A0C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:47:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895D920850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u0WlOiuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895D920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZEx9WJ6DTtq0W5rRyHmWMXgza3W9ikmqlAq0AAxsy4A=; b=u0WlOiuyxThRiV
	Ijkvk8JODQlMILh2C7abbTYSbfh5j+6apkOS0i7/fvpsMOXlPKBN3nY3jD3p7SIfHCIkB8cMRF+hM
	TJ5Ta59gZMV/5+A/+73/gnO0ihWeeZU3KzTlLCxDwoI+6Cx0/szbs+AlfTdhyXbjY8wYTPf0wCD8M
	1H3PKF2QtEiQLBMA/L3cDmkn3pmmO0Do5FdJxDh4TMGxvxPAobSeJgxSoiMj2HjVg07KauCut6/U8
	R2DmU0s20nKj73SxfsdYNwZUdQ6HvZMXmubWj8A3GF4Bzxzh8xYHw+1xGaRP369jop358vu4F2P16
	sKkdAbsSsDAbpTtj2yWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUIX7-0002H3-BR; Tue, 04 Dec 2018 21:47:09 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUIX2-0001tM-Rs
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 21:47:06 +0000
Received: by mail-ot1-f67.google.com with SMTP id t5so16734301otk.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 13:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PH4RkXgWZNeYmS4Q4x0zI5FNArpk5RAZvzpViRvmxU0=;
 b=B1TpRNQ+sKCi0KKpT2C1NQ5AZhP2sC/UntPjCDV/A5JC7ClnU+rkPUH/GPrKpo3taU
 r/KIw5pM4BPq2TArBSB3K9fpxx7j062rQGII3whuwKyeqONiu87m0y7pX8cwIKYh9+bc
 1HxGvxfkY4niGlrWUVbjwLapid7ju4FH7XcR+FKhogk7qTEDHf4wo0ZOI88Jdavfs5rm
 BHClXVg+9ljhScSICFE5sVOYI31dKQLz23TlVDPHZsmurmmNzDddhvVxJFCfXhabdi8+
 Q9C4/PtYtYU6Om9UGgfonAYqPZ61v0zaEGdRZByyEvBuIooyewIjjNSxygBW3Gbxim6n
 Axgw==
X-Gm-Message-State: AA+aEWaY0kcNrHKvQVvjw+HgvniyW9n6Vw5hwI0EdiX47p2rLe4ojXir
 N5+zPGn+79GbHTfJeYZZFaMTQf8=
X-Google-Smtp-Source: AFSGD/U8r9nqGmNPXCxyLbdMTm1TWpWf0xVL0JUdVORxuPT0Qg32FbmHE/RB84KpDnmfhbOXr8/5Bw==
X-Received: by 2002:a9d:7001:: with SMTP id k1mr13005907otj.173.1543960013756; 
 Tue, 04 Dec 2018 13:46:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id g4sm8662152otp.53.2018.12.04.13.46.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 13:46:52 -0800 (PST)
Date: Tue, 4 Dec 2018 15:46:51 -0600
From: Rob Herring <robh@kernel.org>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH 05/15] dt-bindings: sram: sunxi: Add bindings for the H5
 with SRAM C1
Message-ID: <20181204214651.GA12991@bogus>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-6-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181115145013.3378-6-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_134704_902821_CC221BBC 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 15 Nov 2018 15:50:03 +0100, Paul Kocialkowski wrote:
> This introduces new bindings for the H5 SoC in the SRAM controller.
> Because the SRAM layout is different from other SoCs, no backward
> compatibility is assumed with any of them.
> 
> However, the C1 SRAM section alone looks similar to previous SoCs,
> so it is compatible with the initial A10 binding.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
