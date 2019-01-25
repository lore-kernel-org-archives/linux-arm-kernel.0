Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D397C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:14:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29622085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MIllt062"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29622085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=RP/AeOXp//TStBa/mKYC1umfpuXHQF1uSVIns0DNcV8=; b=MIl
	lt062W/iEbaWzefN8Fs/igZ9i3M9dIrdMF1FtklfNqqewGR3naOKhN+5sU2tilOa9I1PzF+R/OOg/
	JdX4P3zfyWUbS2edhboDn5K+twt4HUfsLw4cGsFxzOI+Fm1ldaNnkhXO9MejcnNr1i7B+2h7K7Kw+
	yWirEfYARtIytGrFpJH9lrWM2EkjI9xCi7xNe15/yZ0HMcPjm7Em+s30EDPfVuDxTvgwaahd+8cCC
	NyAAJB5WacWVkS0fuw32dMXA0fa5GGs7xwU16XCso230xOHb1ULMabKMdIdJC1D4zFU3uTTHC56td
	gSJeoguKmBDyvmTzUR4xIWNn8gVBdow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn2FL-0001Z9-Qb; Fri, 25 Jan 2019 14:14:15 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn2FJ-0001YR-6T
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 14:14:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EAE11596;
 Fri, 25 Jan 2019 06:14:10 -0800 (PST)
Received: from login2.euhpc.arm.com (login2.euhpc.arm.com [10.6.27.34])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB91E3F589;
 Fri, 25 Jan 2019 06:14:09 -0800 (PST)
From: Vladimir Murzin <vladimir.murzin@arm.com>
To: linux-serial@vger.kernel.org
Subject: [PATCH 0/2] serial: mps2-uart: minor improvements
Date: Fri, 25 Jan 2019 14:13:15 +0000
Message-Id: <1548425597-38175-1-git-send-email-vladimir.murzin@arm.com>
X-Mailer: git-send-email 2.0.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_061413_250017_6D2F83DA 
X-CRM114-Status: UNSURE (   7.84  )
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
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This mini series is supposed to improve MPS2 uart driver for:
 1. platforms with number of virtual serial ports, like MPS3
 2. platforms with combined TX/RX irq

Vladimir Murzin (2):
  serial: mps2-uart: move to dynamic port allocation
  serial: mps2-uart: support combined tx and rx irq

 drivers/tty/serial/mps2-uart.c | 136 ++++++++++++++++++++++++++++-------------
 1 file changed, 95 insertions(+), 41 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
