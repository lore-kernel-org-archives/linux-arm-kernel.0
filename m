Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC16C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 02:15:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D72A21B69
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 02:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="daWA15it"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D72A21B69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0sp8h+rPLfNCPZZ6iR4HbLA8nZsAXnVpYZNqyiSWsXI=; b=daWA15itWfDmNB
	cCVJ4YHW/mj+XI9Uw0XjyMKy9BDSU0Slg5w15svlr14JGd+4DavLSe35XVx4I9UN020GUT8rjh1uq
	M1l/vU5VKNNHPHeI4Zkkz4ixwEH0IhvWZNYwbuf60AnqEU9Yvd+/SgQoBvCGnAeVeZ6Y5pGejffFN
	8n5GD5859M74hY2Xc3olkKPzcll1nyFhzH/fePzlMYBMgL2A44hx2xQImDZixIPa/3vAxBlHtERws
	WeofxQ+G6YYXXoTPPOAcvppe6YJeTU7ushg358yzS6CuJdanea2rL3FDO9IXgB7rdY0/SjwGznHJT
	r0dLmyIYs6kUHKcs7rDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvBzE-0001Kp-Ag; Sun, 17 Feb 2019 02:15:20 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvBzB-0001JU-Qi
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 02:15:19 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id DFB7614F85B2C;
 Sat, 16 Feb 2019 18:15:12 -0800 (PST)
Date: Sat, 16 Feb 2019 18:15:12 -0800 (PST)
Message-Id: <20190216.181512.1897027899992353133.davem@davemloft.net>
To: alexandre.torgue@st.com
Subject: Re: [net-next, PATCH v2] net: stmmac: use correct define to get rx
 timestamp on GMAC4
From: David Miller <davem@davemloft.net>
In-Reply-To: <1550160224-8927-1-git-send-email-alexandre.torgue@st.com>
References: <1550160224-8927-1-git-send-email-alexandre.torgue@st.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Sat, 16 Feb 2019 18:15:13 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_181517_867711_3DB248C3 
X-CRM114-Status: UNSURE (   7.38  )
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joabreu@synopsys.com,
 peppe.cavallaro@st.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Alexandre Torgue <alexandre.torgue@st.com>
Date: Thu, 14 Feb 2019 17:03:44 +0100

> In dwmac4_wrback_get_rx_timestamp_status we looking for a RX timestamp.
> For that receive descriptors are handled and so we should use defines
> related to receive descriptors. It'll no change the functional behavior
> as RDES3_RDES1_VALID=TDES3_RS1V=BIT(26) but it makes code easier to read.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

Applied.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
