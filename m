Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B9DC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:51:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48750222B1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i/uGDxgv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoIargHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48750222B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C+/nqNQeU0dZaPLTxVk6TqpZ2G3UUqhHROl1/ohUId0=; b=i/uGDxgvZ4gyJu
	N/qNsxIs+tAh+EBnlcteDqn7sfGEYciRRmj/pWWRsQnzrgXfL8I3B0e6ifx8JeU9+Ym1oEZjH/vNk
	2eqAmA40hziYciXwHV7sPhizoUXIFu/W+9hWlpBVoTN6um7TishVcxWkWFPpIkbUAW2mDh2RfDIds
	ea5UWGUQM8mGOEC1e/F6psFWMWyHXUKCOkXiwUQHGyHDDRR0ypCzQEb0fwBy6MVaWL9o6rXq1LYb9
	vkxKELM/eePS+DZB5IzTVCOhLkSvR7CPlXpSCAxlUlWBDcSSZ7A2NlFSXaUJqbHtoorm41Q9zIsCZ
	VYlow0zHIGnWlGnJsdSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtyge-00033Z-4r; Wed, 13 Feb 2019 17:51:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtygX-000335-Hz
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:51:03 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 245672086C;
 Wed, 13 Feb 2019 17:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550080261;
 bh=ascWrEzuBIrqSmJ9EcN6LJtQC5jsAmWdNAcVbk7fB/Q=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=XoIargHhURDCYOQYNJfZv6jSfmDFNfRRAX1c8+CM7kiTHZf+HIOVz9buo5HarkPv0
 sD3Hq4qaZfy1hcuMLp5nedhqsxB+/JrpedBxQM/YLT6bVW5eehFA4vYml0ptK+UxJI
 arq4Au7ubsk/Sud7c5cH+jQcTPwDUmrc9tJOVGS8=
MIME-Version: 1.0
To: Alexandre Torgue <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, gabriel.fernandez@st.com
In-Reply-To: <20190212135154.2733-2-gabriel.fernandez@st.com>
User-Agent: alot/0.8
Subject: Re: [PATCH 1/7] clk: stm32mp1: parent clocks update
Message-ID: <155008026039.115909.4164384033475100688@swboyd.mtv.corp.google.com>
References: <20190212135154.2733-1-gabriel.fernandez@st.com>
 <20190212135154.2733-2-gabriel.fernandez@st.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Wed, 13 Feb 2019 09:51:00 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_095101_730149_0998E61B 
X-CRM114-Status: UNSURE (   5.04  )
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
Cc: Gabriel Fernandez <gabriel.fernandez@st.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting gabriel.fernandez@st.com (2019-02-12 05:51:48)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch updates parent clocks for axi, fdcan, sai and adc12.

Why?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
