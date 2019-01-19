Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4993EC61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:42:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0742084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="muPFz1sd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL2GNqGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0742084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=/L8WCgiGcI9FTAHu1OgbzTeGGV9JXdLaujh83F3pgqc=; b=muP
	Fz1sdpX1KffGs+PMXlGtk4Cun63KwFzq071amc4Rp8o7YezvkdLFK3p1wnRjTyXnAOlo2IYqNklgY
	Tp/6n+y1exU8m4CHXBv2oh9hxKjwwg9C/m7mdynN7EN3DH2WQ8Igrd6GkHUz4jaIe505PH3/2WfEU
	B2AaCfVne39gt/eh3TFNSVPDFVqZwV8QdvTXlxhrd2n+xVwBaE/EiZjpaZF/hRfADkc1uGyKxvy9u
	nsn6aVAIhCsF8KHx3k5i3gfrFHoP6xFz7iNPNWqiGrsjsJuEFIszHqqUQv8E3yRpv/uy2XPjFYsnI
	2B9ymkbssf14xTxwDA+JlK8Fllz9c7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gksl5-0006vw-Kc; Sat, 19 Jan 2019 15:42:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gksl2-0006vH-Fv; Sat, 19 Jan 2019 15:42:06 +0000
Received: from localhost.localdomain (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6822F2084F;
 Sat, 19 Jan 2019 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547912519;
 bh=pd3JnVRvx9qXga1PfmEpbi76HIFcTcq5J/fGSAxb3fk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:From;
 b=bL2GNqGt6U/MR0TQLIcVRdOoga6bmlPU4Vkc2c+9qy6OYKdYRRN7blMOA5v2mFSrc
 Rp9yVHctUiEmxdfjs2CO6owa/AAbGpa3ofXXEevtUdVyHUjojeaK9wL48inQcnF5Tb
 FAfFL25UScLUwgIUZBDI2RBO27sGBTCCqnwZ1Vwg=
From: Boris Brezillon <bbrezillon@kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [v7,3/5] mtd: m25p80: add support of octal mode I/O transfer
Date: Sat, 19 Jan 2019 16:41:49 +0100
Message-Id: <20190119154149.3451-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 0837ae46ff003fed44bfead23c590e7105f47623
In-Reply-To: <1547546584-5254-4-git-send-email-yogeshnarayan.gaur@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_074204_563388_77B6E30F 
X-CRM114-Status: UNSURE (   6.10  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-15 at 10:05:22 UTC, Yogesh Narayan Gaur wrote:
> Add support for octal mode I/O data transfer based on the controller (spi)
> mode.
> Assign hw-capability mask bits for octal transfer.
> 
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to http://git.infradead.org/linux-mtd.git spi-nor/next, thanks.

Boris

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
