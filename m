Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413EAC0044B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:02:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13AA9207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E0CHQbnC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNIeVIBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AA9207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GwWjMSxnSRvKpyk6mFsBWCfBrROcDH/xObgkF8DTaLk=; b=E0CHQbnC3q76E9
	shQNSG+wKOXS5xvlMLb/QIuCEjrMAY1i6gohMqTnmTOTMD/qCmfo5Ekn0SXYpzG/ECXwcRp1vcy6O
	QPCXZ0gpQ7Gz6ZRFTbhVNioF6W398Y9UyfxsCMmq9rV8vuIJcTxhCTUTaqD6/aNm91JelIv5bGyWq
	lNUUJJjR5O4py901LJyGx7eKMD1h+koWi8I71q7Cwbng/jVhAlQyoE+RsNRU3nuccMe2vD8PUpCAv
	B85wTpEB+ulWkBuMA78P8R68U+iNfRpdEMwHzG9QOhGxcAVliKAyOWzAwa1ITM5Gi3KDjJL3SiXUj
	AdlaXIYlWuzRuIg5ClTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu1fV-0006Hx-4Z; Wed, 13 Feb 2019 21:02:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu1fR-00068L-6p
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 21:02:06 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AD231207E0;
 Wed, 13 Feb 2019 21:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550091724;
 bh=9X+gzRmSf+BHmR3RUa0gPVqj5qvtMZulGLtfrswIXdM=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=ZNIeVIBzr8EiPpXNY5PGNvn/Ol+yuvol4uG3W30OpuRiVRq1T7vGEIlSjC2gzHiBw
 actim0hMjCjgFR6nYobCG2zo5SA3TIPFus75V9GQyJbyaVmsZMWwrXrz6O1+nHCaKB
 sxhwO/NcQTp3v91yEA8tQncsHvyoMHgJANIxtB3w=
MIME-Version: 1.0
To: Alexandre Torgue <alexandre.torgue@st.com>,
 Gabriel Fernandez <gabriel.fernandez@st.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20190213100714.15622-1-gabriel.fernandez@st.com>
User-Agent: alot/0.8
Subject: Re: [PATCH] dt-bindings: clock: remove unused definition for stm32mp1
Message-ID: <155009172384.115909.11842128085275839689@swboyd.mtv.corp.google.com>
References: <20190213100714.15622-1-gabriel.fernandez@st.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 13 Feb 2019 13:02:03 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_130205_268896_50F40F99 
X-CRM114-Status: UNSURE (   7.17  )
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
Cc: devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting gabriel.fernandez@st.com (2019-02-13 02:07:14)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> LTDC_K and ETHMAC_K are not used.

Ok, but do they exist? It's part of the binding so I don't see how it
hurts anything to describe what is there.

Also, please send patches to the linux-clk mailing list so patch
tracking can work.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
