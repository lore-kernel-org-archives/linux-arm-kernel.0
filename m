Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11FEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:20:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5AF217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g7P/zRIh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xazLEy9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5AF217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KqHLQv0o2gVW7JBrLOCh9O760DyZvcWwrZ25HNzRA5I=; b=g7P/zRIh/GE+a4
	6w2sUQyjWOdLzcD93U05pZx39gKAwF1bUeiyrHxwyTc0uo932EGOxgkbjoeCcIkOto3ZELCP1UAO4
	lMTzNQyxQ23HVMN5MipIMZ2A69wYeUIYXujijezVZljy98BRdjx5pktt8el8kqTeSbpBDS9bLpUIK
	xyphG6xuQrQ7cIhswANKgrTMwp+Tn1Qo9ykEVUD/PXhZlEae/sRhP0v28MM3IaYjeJRIeEn+a79K/
	Pe7aFLuNqZzCAD4N4vmQXJoA6+QSFsOM6ygLjZ1ZubKaiU4WDYBJGvJ4sy7EWu/MqBF+EDoAYlF3z
	+EYJtxZR2tsYqvyIX4cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYmGM-0001VR-7X; Mon, 17 Dec 2018 06:20:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYmGI-0001IP-KF
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 06:20:19 +0000
Received: from localhost (unknown [171.61.92.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 09BCE217F5;
 Mon, 17 Dec 2018 06:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545027607;
 bh=B9g85TgZ3lGVWga/ob1Pvz8P1H1bmKrgu/pcgPbgNy8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xazLEy9wzxalhq1TQyCGYaIc2y4YMqi4RohuIJAP7mN7WrI9WZJNa8Na+4141QJx5
 DanrfCcRTRuQUIKaUkOhb3zKKrOuNLD3dL2mNrKOt6APglqUa7tYrnqobu3bLY3Ht3
 oMunLhX7rCoDC0LxUOpmxATRZBDVj4bhNbRwHbC4=
Date: Mon, 17 Dec 2018 11:49:59 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH 1/4] dmaengine: amba-pl08x: convert to
 DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181217061959.GG2472@vkoul-mobl>
References: <20181205161900.16434-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205161900.16434-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_222018_685670_2F2D3F87 
X-CRM114-Status: UNSURE (   6.60  )
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
Cc: dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org, okaya@kernel.org,
 sudeep.dutt@intel.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org,
 ashutosh.dixit@intel.com, david.brown@linaro.org,
 linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org,
 dan.j.williams@intel.com, robert.jarzmik@free.fr, daniel@zonque.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05-12-18, 11:18, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Applied all 4, thanks
-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
