Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC661C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:20:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBBB92087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SCXx+HT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBB92087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=srSr7r59/xdx3bxplRK0Gips5FUev2QWP+zA3TQUd5g=; b=SCXx+HT7yLqkjG
	84OIVO/uTv3MlGOJ7p8PFEEm2w4mnJWMsb2MvNzMswMeofvx9e28RkjgqZ0dOQExDBSzLM1Auc5tB
	fIAcfokh3cG6AU/pQ/Bjh5tDmpKQ6LnGCG6yQKaXB6jTgBY6oGg3ZhFoaVf6reGkMKWtyieHxhBRf
	VE22aCQ6mysA32WyJhBWrDQS0iEsIvmFs/nqghFPnUFAe4+Uf/R4h30Rs3CnThc/dwYquz3/Zj76J
	m4NpN2K3RjFfSiujneDY3xNuTe0OcMZtqOoC1NhRc7oDo4Vf/1uqZioOMcNH/lcw3ZNrUhqUQ7/Nh
	07CCO8dX52A5M8LdmMDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy7kj-0002Sl-LP; Mon, 25 Feb 2019 04:20:29 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy7kg-0002Ro-Ht
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 04:20:27 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 74E5014DAA3BA;
 Sun, 24 Feb 2019 20:20:19 -0800 (PST)
Date: Sun, 24 Feb 2019 17:45:39 -0800 (PST)
Message-Id: <20190224.174539.990511736656408555.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v2 0/7] net: phy: marvell10g: Add 2.5GBaseT
 support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
References: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Sun, 24 Feb 2019 20:20:20 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_202026_596663_6446D529 
X-CRM114-Status: GOOD (  11.39  )
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
Cc: andrew@lunn.ch, f.fainelli@gmail.com, antoine.tenart@bootlin.com,
 netdev@vger.kernel.org, gregory.clement@bootlin.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, nadavh@marvell.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, stefanc@marvell.com, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org, hkallweit1@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Sat, 23 Feb 2019 00:37:37 +0100

> This series adds the missing bits necessary to fully support 2.5GBaseT
> in the Marvell Alaska PHYs.
> 
> The main points for that support are :
> 
>  - Making use of the .get_features call, recently introduced by Heiner
>    and Andrew, that allows having a fully populated list of supported
>    modes, including 2500BaseT.  
> 
>  - Configuring the MII to 2500BaseX when establishing a link at 2.5G
> 
>  - Adding a small quirk to take into account the fact that some PHYs in
>    the family won't report the correct supported abilities
> 
> The rest of the series consists of small cosmetic improvements such as
> using the correct helper to set a linkmode bit and adding macros for the
> PHY ids.
> 
> We also add support for the 88E2110 PHY, which doesn't require the
> quirk, and support for 2500BaseT in the PPv2 driver, in order to have a
> fully working setup on the MacchiatoBin board.
> 
> Changes since V1 : Fixed formatting issue in patch 01, rebased.

Series applied, thank you.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
