Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A3DC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:53:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4242080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pgzVQ4Rv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="pIH4xb0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4242080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q3eVqRCLxxj9ruCXCHd9IXx5UHjAVXiVH5E/vx+0KLE=; b=pgzVQ4RvKxf2zQ
	15v7fSpOxzaPYc/On7M4eGq3/UXiXOnhAeU6nqo3MTjEag3edW56yXCMBu/I6pKgURt3Qs9cf5Xp2
	tQkLRqUs8lrYDGuNbdVMT7C9F6F2jKHw5dU3QBbt4vK8ux1Rbxvb7UurDGufBvXBwhgyPuCdozQRX
	EqCSPFN1UuG4FnKbVKe9oZjc6R3ZATN9tRqhJz56kYOFEW5p6Keq/rh/vCDaUDaCBETLpBNjtxRsT
	Fmrqu+rxMho7okctOS5wrNeEktGL52v4b8O/Hg4AELvoVB3UEWwxbdv+/yesD7+VXjLkCUPUS2TtY
	v69gJNpdNOx8pfHmZbww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXKsA-0005hI-4H; Thu, 13 Dec 2018 06:53:26 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXKqc-00047H-LF
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 06:51:55 +0000
Received: by mail-lj1-x243.google.com with SMTP id x85-v6so803008ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 22:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=l1e5G6yYmnCAnTFOusvvUz8qE4vsHqVuAYNLZZXTLcU=;
 b=pIH4xb0Q9kzGzo7L1exO7CoHj60D6Udssn0QWUrlJtUWDt//k7RHZcHXgqYERvxjGy
 JtXV3tqXU1sT0QWGY0MltL841cBaVR9ItKPMpruQpPfGNlbIORiM5ai0qJPgyqeX0Dv8
 esiJSm6df51odZcAzZOJNP1mxjZS0LH0CfFTtHneY0IkQhrzyqB+exa9WwEvnLA0Jwz8
 cyD0bqDehwzIgXLA4XhvjhziOnzyG56DFDjZS0udBpzxkXE33xyByXkMKUsCt0nvXSzT
 JvbA/nTCOLmBS0ZQwcq1ve8xIfNvljX9PqBVUososQdHpzYuTf5Zjn62QlhDZaIT3nOm
 VsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=l1e5G6yYmnCAnTFOusvvUz8qE4vsHqVuAYNLZZXTLcU=;
 b=mRad1Y62JGmY6jp5tIpxf8iGJDY0pB7hRoQI7Lmhl8fcGq57Q8GtMOCvGCW+/Do4KR
 3GqOkFVq7fOAEPQ7nqGrRDoOF8A4IsYL+M82CYZOnNgQBsJeNb1TXDOAPb0S/Ymn//KO
 jNNB0jfTz7VkPIQVFVLJ/PZUkSKJUDckDx5KQEBCH5C9AAo3o5zutazr1hp2iiE1kEEy
 7TQ06kECsVAfRLvHJSCwmWVMoyh2An+HGblcNOdnvUbaFpgXYyWjpVjn4Pv7DDBCgrPS
 rRdJFBFgnpIo6cOt3kST2C8ObZB78kMseLDdmlfi5QsJ0i4bcGhGmzO8mJOfvIUYiYpM
 sHDw==
X-Gm-Message-State: AA+aEWblLaYqXBCBe0TleUhKxYJaf/RIOWgAwSonWT2TZnT3Ui+eMhrJ
 vwPmgBkuPsmpOBzfc5hniM7hFw==
X-Google-Smtp-Source: AFSGD/X/EscbVG2NmCqclaW72hLIhSIfBuATtNiceI1IMyKyj9W0Bxkh7UTeXnJ9IkBm3/qqBS4UXQ==
X-Received: by 2002:a2e:9819:: with SMTP id
 a25-v6mr15250615ljj.6.1544683903534; 
 Wed, 12 Dec 2018 22:51:43 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id y14-v6sm151776ljj.55.2018.12.12.22.51.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 22:51:42 -0800 (PST)
Date: Wed, 12 Dec 2018 22:48:38 -0800
From: Olof Johansson <olof@lixom.net>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v3 8/9] arm64: defconfig: Change SCSI_UFS_HISI=m
Message-ID: <20181213064838.f5goiwqu4tkkcmgd@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <2f3fdfc8-24ef-734b-7c4a-76da9f7556be@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2f3fdfc8-24ef-734b-7c4a-76da9f7556be@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_225151_295514_EFF3D16F 
X-CRM114-Status: GOOD (  11.82  )
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

On Fri, Nov 09, 2018 at 02:08:07AM +0100, Marc Gonzalez wrote:
> SCSI_UFS_HISI depends on SCSI_UFSHCD_PLATFORM=m
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  arch/arm64/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Another one that got covered by patch 1.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
