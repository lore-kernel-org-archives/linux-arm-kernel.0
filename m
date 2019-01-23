Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF8BC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:56:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ACDB21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qEKw4SPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACDB21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HDVZksDq3HLtm/9ghnslAC9ncinDybMXvQCGn7G62uY=; b=qEKw4SPE89YD3X
	79r5hJptq3m1q15swLRUcv9qQsvlVk/tov/ja/iy9r9BNaB8L7ljs3DGZW/e6LpGs4vGUQ3utpxw+
	4+bbWVsh7n2eTjjzTlGVlDYDXyAXEnI96Kpg9qwGDzEVxfAqpGmO6Kz3QaGhRG1CRqnYT7/pyinYp
	V1QITKRl9QWROI1s+V5JZHKvnQL4yepzGUxvN3vRrVtN/52MoyD9cvRNsBFHUBAnOrr0R7/+AmctU
	AYWbgajv9C9MMw6SZvb4j8Ycj4/B+B1q1JBNLFrhtUNygOtNyEPaBWFdkS+78L14+8nwFEXcXlxIz
	UndX4ydAHnqVFRPHUTjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmQVv-0001p2-2T; Wed, 23 Jan 2019 21:56:51 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmQVr-0001nf-Pf
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 21:56:49 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id DCA1E80FA;
 Wed, 23 Jan 2019 21:56:52 +0000 (UTC)
Date: Wed, 23 Jan 2019 13:56:42 -0800
From: Tony Lindgren <tony@atomide.com>
To: Martin Sperl <kernel@martin.sperl.org>, Mark Brown <broonie@kernel.org>
Subject: Regression in Linux next with SPI pump changes
Message-ID: <20190123215642.GK5720@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_135647_867048_9924E302 
X-CRM114-Status: UNSURE (   4.43  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

Commit 412e60373245 ("spi: core: avoid waking pump thread from spi_sync
instead run teardown delayed") caused a PM regression in Linux next
where a SPI device (drivers/spi/spi-omap2-mcspi.c) no longer idles
for PM runtime.

Looks like this also breaks suspend as reported at [0].

Regards,

Tony

[0] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899265.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
