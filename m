Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBB3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:59:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41306222DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gYAjBAn0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="saNH1fyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41306222DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N7G7jDDHeph9DWyDMK2oyHqb3EXhMFd0Bw4XRsKR2Hw=; b=gYAjBAn0H4rS1R
	3eRF2suKFBnKnstRRpYvy0hFx5N3yGofJAn6BUwt5ZzKoFUtAtY7EuJe2b7UOHfczzpj+sbFWfp5+
	kEmqLPmvTLmFJmVZ+lUP473FeMcDpvAOCOv4CmvqC9rTXrl92phdERRuxEa1/PagkizKCx2vZmF2k
	0+W063AbtoqdT+tvFaB4v20OVWSlM9PH5Y5caFOfXQuqUBGbYJGJggv1YYJj7AkZdyz67iLVUSA/O
	94FoXf2a9q3OMbP0lyZKf00AX4slLEyqRtV6KAPDPRlptqWEmvQOlwC20GlqBXMGsSy1Wyv6mrDe8
	WXc+cZvGgTrEKrU8IUdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gunOA-0000ce-Ti; Fri, 15 Feb 2019 23:59:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gunO2-0000c6-Kv
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 23:59:25 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 466BD20842;
 Fri, 15 Feb 2019 23:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550275158;
 bh=0f65xSjh/o4jnk7SshkR45mM0SLydxgV75Q71pDb/QU=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=saNH1fyWJPA169Bg41My8rvnGOiWJ0dsj45/Wr6NhwoM3Qge+c46CcVddZY/NIUMY
 NtiGuKd+J+dteTeo7UwtqgHuv5pZmOzeFXm+0o03kpcmAqPjVvWWhA04L0VSj4E0Y/
 kRlIw7XPYM3iSqWiA/skHA0LTxIPkx1eZ4BOa8UM=
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
In-Reply-To: <20190208104230.zn4sn7z4idge4gmh@flea>
User-Agent: alot/0.8
Subject: Re: [GIT PULL] Allwinner clock changes for 5.1
Message-ID: <155027515755.115909.2383410991418569831@swboyd.mtv.corp.google.com>
References: <20190208104230.zn4sn7z4idge4gmh@flea>
From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 15 Feb 2019 15:59:17 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_155924_333569_6DC66D22 
X-CRM114-Status: UNSURE (   6.31  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Maxime Ripard (2019-02-08 02:42:30)
> Hi Mike, Stephen,
> 
> Please pull the following PR for the next merge window.
> 

Thanks. Pulled.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
