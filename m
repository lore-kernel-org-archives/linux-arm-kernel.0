Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7216C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:21:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941762080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dyTLuKBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941762080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PXC4nipXOCDool1+87Fnf4ZLqoAJI9cXtmefD7vlg5I=; b=dyTLuKBPWEfPV/
	pOr+t6rZVxOWe5YN4k7f7tE/eOF3XtMHawtUJaYgzShct123z1f/9LoNeSsW0T/22n3E86UkbcC1e
	SUR1o0sqAytHj/hCsJtkcLKrHW3ciSy/Z1msroMGT1Pr+FPuhGMkZkaIFrjalSTTMjBA213iGk+bN
	IRtMr30IigIdJTZxWieOeX0upp/hUdjE+485Y7pCg0Ipfy5dlA+wr+pG/T3HdnLBbs7txYkM5P0U0
	G7wPgVJoXIZhl9MV5i80OSk1dQgiNztWoCMWfiXYMiRE404K0SOGCqqJ5UHM+XJ6kW6y12Oe9LAtF
	oJXr7dy2TvUQrP1mZVDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXDot-00083v-3x; Wed, 12 Dec 2018 23:21:35 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXDop-00083E-GK; Wed, 12 Dec 2018 23:21:32 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 9684E149B269B;
 Wed, 12 Dec 2018 15:21:15 -0800 (PST)
Date: Wed, 12 Dec 2018 15:21:14 -0800 (PST)
Message-Id: <20181212.152114.107710423985118689.davem@davemloft.net>
To: biao.huang@mediatek.com
Subject: Re: [v6, PATCH 0/2] add Ethernet driver support for mt2712
From: David Miller <davem@davemloft.net>
In-Reply-To: <1544607332-29921-1-git-send-email-biao.huang@mediatek.com>
References: <1544607332-29921-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 12 Dec 2018 15:21:16 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_152131_549639_7EE95DFD 
X-CRM114-Status: UNSURE (   6.27  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nelson.chang@mediatek.com,
 andrew@lunn.ch, netdev@vger.kernel.org, liguo.zhang@mediatek.com,
 joabreu@synopsys.com, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Biao Huang <biao.huang@mediatek.com>
Date: Wed, 12 Dec 2018 17:35:30 +0800

> Changes in v6:
>  modifications according to comments from Rob/Andrew/Sean:
>  1. use delay_ps instead of delay stage.
>  2. add comments in driver to avoid confusion.
>  2. rewrite set_delay function.
>  3. modify binding document for properties: tx-delay-ps/rx-delay-ps/pericfg etc.

Series applied to net-next, thank you.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
