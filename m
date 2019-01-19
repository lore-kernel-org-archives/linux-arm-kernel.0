Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B773AC61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:43:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F79F2054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n3AvVpZV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xC2sImbh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuGs/whp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F79F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=S7GRROWwh4L8sE8A92mLKzZchJOU4Z+HwI2vo8wH0R4=; b=n3A
	vVpZVLTNA9wePIckipu+PhYN2R95iHxyXR2uX39s8iHbW65l1xpOv+O7XGY571HW1fhwO5EGgQNUY
	JWH/ngM4dIPit9eRyP5OORuvnVmR9r6f0q5V6SivHVk9vI3rxtEQlwC8qQa8P+lyfhJMS0cFTQjAl
	YUAT81C6MVjojnorGzX0kWUJ1qlcj9H78DjekIwsIwEyDMg06uv+TDMUCqnpiRFKFXnPUeh42RMZO
	o+UZ4jE6sw2MjK1PNIT5vFPyl54k04LenFRyyOUpmj201XBGFS5Xd45zJyHJwdAeyfsiOy1TKLcZd
	80m5Qol6DpCuWlZRR0kIndkVOdxWOHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gksme-0008SI-4Z; Sat, 19 Jan 2019 15:43:44 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gksm4-0007ye-VQ; Sat, 19 Jan 2019 15:43:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ILVB/xBZpYV6cntTsLdRz022xV1Q1yqzwkrz43tLaz8=; b=xC2sImbhj9AbCekm88/7Pxf5up
 IeTyQsW4A9znsxRZosieGsdI032Ro/sz3OL7Wsa4foqLZFpki84E2+QIvvHZmlV7zs0SEtDtX30pS
 UgDUdWOC+m+7/8myL83xJNB3LhCdKpJ8kRpdTNaeQaWU/1PBu2jx0DrxlvrszyG5HJG6TkG53OAiP
 weVGqZp6Y+9SzTxKUThrarBxNVZPZVdQLjHV+gCeVKwp57017fGojTICVoxbKCxhoe6If+Wkt3tli
 gwxmhUfk9zyUC/6/S6jNfH7whrqhBhBtD4pqrkFuORNhW1ZjSn96lOYVovdjwH6NXcggj6EnjlaVV
 qblKiX7A==;
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkslz-0003QJ-D7; Sat, 19 Jan 2019 15:43:04 +0000
Received: from localhost.localdomain (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9A4F22084C;
 Sat, 19 Jan 2019 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547912577;
 bh=QHGE4X/SMd6Gk4Y/RvZDd4ym48B2gZlOPy5H8LSkrZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:From;
 b=nuGs/whpR0XQMW1BDtUnXgLCLdopjdOSsZvpTLzAJRws/E61dprNRpVkO3okJI39Q
 NOxfOEMYSsCY2/rvFtfgE7q00eZK9VostqJYcIGvpN5FaBejE15UtbanK1qx83Zlrd
 Nx7bcXrF47lq//B+95x2/ZUADbkTEYgvP0xe0+cY=
From: Boris Brezillon <bbrezillon@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, Marek Vasut <marek.vasut@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [v2, 2/3] mtd: spi-nor: mtk-quadspi: add SNOR_HWCAPS_READ to
 spi_nor_hwcaps mask
Date: Sat, 19 Jan 2019 16:42:48 +0100
Message-Id: <20190119154248.3733-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 9cca9b3e55989f8b227d05897877648d67910a6d
In-Reply-To: <2afa18c0c898259fc244f15844c5319f71e811df.1547538621.git.ryder.lee@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_104303_513151_B1B60A46 
X-CRM114-Status: UNSURE (   9.09  )
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
Cc: devicetree@vger.kernel.org, Guochun Mao <guochun.mao@mediatek.com>,
 Boris Brezillon <bbrezillon@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mtd@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-16 at 02:12:04 UTC, Ryder Lee wrote:
> From: Guochun Mao <guochun.mao@mediatek.com>
> 
> SNOR_HWCAPS_READ should be supported by this controller, so add this
> flag to spi_nor_hwcaps mask.
> 
> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
