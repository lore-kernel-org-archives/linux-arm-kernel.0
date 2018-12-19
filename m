Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B874C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:44:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C874721871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MYadLtY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C874721871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uwFpjhOYZR6HJxoTleJIFRkstlwIkLVm8zE0PxSHcvU=; b=MYadLtY3wAYIwG
	0U5/4br3piPymEp2dEFFrK+6CJHAi5F2OpYMq5ibBOv6YizmzUU/GPeKvXjWjj4o6/oIezrgaybTw
	HvJ+aCCEvyCVEI4EOTsbi8pB1BwUavZY85UN4mk8AbZmt9sfm4s+Q0Dejpxg716SK4+INp6NltLyk
	367dtlBgyjTyPE2Q+3Fu7emgn+UgL9moQ41nSZfQgI+YvgjSRilIZR28/1kE36iOn/Ah4HBvGsGXS
	qcqAwW6jZpp2jV3h+UrXgB9phdx9Iv+oWc03qv6VBP+D58qKudTDgqOyqmDBZdcbpGGknZ+mJHLVz
	rVUiQMmwskuW5vHRzPVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZUeH-0006Yx-OB; Wed, 19 Dec 2018 05:44:01 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZUeE-0006Xo-Gn; Wed, 19 Dec 2018 05:44:00 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 9DFBF12640956;
 Tue, 18 Dec 2018 21:43:45 -0800 (PST)
Date: Tue, 18 Dec 2018 21:43:44 -0800 (PST)
Message-Id: <20181218.214344.703245035605109815.davem@davemloft.net>
To: biao.huang@mediatek.com
Subject: Re: [v2, PATCH 0/2] add ethernet binding and modify ethernet
 driver for mt2712
From: David Miller <davem@davemloft.net>
In-Reply-To: <1545112096-22737-1-git-send-email-biao.huang@mediatek.com>
References: <1545112096-22737-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Tue, 18 Dec 2018 21:43:46 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_214358_561700_0A2DA5FB 
X-CRM114-Status: UNSURE (   7.63  )
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
Date: Tue, 18 Dec 2018 13:48:14 +0800

> changes in v2 as comments from Sean:
> 1. fix typo.
> 2. use capital letters for RMII/MII/RGMII in driver and bindings.
> 
> v1:
> This new series is the result of discussion in:
> http://lkml.org/lkml/2018/12/13/1007
> http://lkml.org/lkml/2018/12/14/53
> 
> 1. ethernet binding file move to this series.
> 2. remove fine tune property in device tree
> 3. remove fine tune flow in ethernet driver
> 4. set rgmii timing according to the value in device tree,
> and don't care whether phy insert internal delay  or not.

This series doesn't apply cleanly to the net-next tree.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
