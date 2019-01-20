Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368D1C61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:32:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035082084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GG5y0tjo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="X7QkXQ4O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="X7QkXQ4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035082084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=dQwicRrjGtk0PvKRxzXEs/rIy7hwk7SU9qfQhjLL5Go=; b=GG5
	y0tjouVls0wVgUl8DmdeJXceEqzcI6qOH0qL8w1o1pESBa+kOMBsfe3Kah63b67v6MUHmkL+Yhb+N
	IsihYnr00xK+5FJBzKPI6R4cu6AQIL3vaxgzU9WPWEeWTrCLuIygUQv5HQWvnXtjTtkzXwpcCHppw
	inSiGF5dhdl1gMyl9USybz9bLhLRJmMLZ65Qq13DxYM0ibPgu/TubH22LEWzTT8jJSfRTr27eIc+k
	AJSIVequVEFg+MIBTPhmk9KFUWRaiE8S5x15c52c9BUe6lKs/Dhr/N+mvCXJ0AWA+kvNnbBRav/e7
	m+MU+8i7a/M/Wzu3onijf+JTQ0NS3SA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl2uf-00020g-7X; Sun, 20 Jan 2019 02:32:41 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl2u3-0001T9-6X
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 02:32:05 +0000
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id 937A14E2050;
 Sun, 20 Jan 2019 02:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1547951521; bh=U3u1ymfYif5svjWWDk0JiwVizRuEI3eEjAatwNEEO7A=;
 h=From:To:Cc:Subject:Date;
 b=X7QkXQ4OhFqZ9nUvw3Cn0kukA5mfmmEIYQarVNLQJl46PEdPg+XEi12+65k/RmWiu
 hrhtNOKm5l4xH1T/V0PnDo2A7PsJNTUppaXbIUy9/RMGxAIVZK8xhWneZdrPGBAm59
 ierLZbkvMVbCYxcLGgoJf7WV7jDK1nF1zfcnW6VA=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6LG6ktte-aVq; Sun, 20 Jan 2019 02:32:01 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca
 [198.48.167.13])
 by node.akkea.ca (Postfix) with ESMTPSA id A4FA24E204B;
 Sun, 20 Jan 2019 02:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1547951521; bh=U3u1ymfYif5svjWWDk0JiwVizRuEI3eEjAatwNEEO7A=;
 h=From:To:Cc:Subject:Date;
 b=X7QkXQ4OhFqZ9nUvw3Cn0kukA5mfmmEIYQarVNLQJl46PEdPg+XEi12+65k/RmWiu
 hrhtNOKm5l4xH1T/V0PnDo2A7PsJNTUppaXbIUy9/RMGxAIVZK8xhWneZdrPGBAm59
 ierLZbkvMVbCYxcLGgoJf7WV7jDK1nF1zfcnW6VA=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: 
Subject: [PATCH v2 0/3] dma: imx-sdma: add the sdma engine to the imx8mq
Date: Sat, 19 Jan 2019 19:31:47 -0700
Message-Id: <20190120023150.17138-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_183203_333610_C8EFE2FC 
X-CRM114-Status: UNSURE (   6.30  )
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
Cc: "Angus Ainslie \(Purism\)" <angus@akkea.ca>, linux-kernel@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add sdma support for the imx8mq

Changes since V1

Fixed to build against v5.0-rc2

Angus Ainslie (Purism) (3):
  dma: imx-sdma: fix NULL pointer de-reference
  dma: imx-sdma: add clock ratio 1:1 check
  imx8mq.dtsi: add the sdma nodes

 .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 31 ++++++++++++++++
 drivers/dma/imx-sdma.c                        | 37 +++++++++++++------
 3 files changed, 57 insertions(+), 12 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
