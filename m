Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA20EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:53:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F2C2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MZ4zy+ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F2C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zaCvVls0kE/G9mATHH9m6XpZnpL2U4UAPTULRuUgN8U=; b=MZ4zy+dsQPdQz9
	shDmfloV3k6/5UDwMHKzru+i5M3XNVHOFrR9hgJw+ThEztknoVKlXLL40tYYaO0hcK+YXSo+8KE63
	3ST2zP1l42r8sBVy4pFMAt7Qrp2wh6eWfBrQ04OnFFyQv70YQMtGKeqRoPUB6gzzpJNKQAIOpsDiE
	CI6AQ3I4fvRhmFcH1tSCSTMpiit1gV78rsJEMdloy6qA1q5vwYb9tYnzSldUfo15Nt6XEedFZkXKu
	tbFltWbEIY2NVHWxl0ogKIMAvWbciynvGBpZ77HOWL/uBaO0sh/u16aaauuIsOazb7RC8TSgbF2B5
	4M1WE7YOM4+oQaZ9dHhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwV7l-0005hD-42; Wed, 20 Feb 2019 16:53:33 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwV7g-0005gm-Mw
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 16:53:30 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 107421BF207;
 Wed, 20 Feb 2019 16:53:21 +0000 (UTC)
Date: Wed, 20 Feb 2019 17:53:21 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: "Jonathan A. Kollasch" <jakllsch@kollasch.net>
Subject: Re: [PATCH v2] arm64: dts: allwinner: fix status LED on
 nanopi-neo-plus2
Message-ID: <20190220165321.24eer575gjxi3pdx@flea>
References: <20180703132636.21587-1-jakllsch@kollasch.net>
 <20190220153303.32081-1-jakllsch@kollasch.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190220153303.32081-1-jakllsch@kollasch.net>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_085328_926406_A017208D 
X-CRM114-Status: UNSURE (   9.57  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi!

A few generic comments before, you should send the patches to all the
recipients in get_maintainers.pl, which means that in that case in
particular, you forgot to send it to Chen-Yu Tsai.

Also, when you're sending a new iteration, please provide the changes
you made since the previous iteration after the ---.

On Wed, Feb 20, 2019 at 09:33:03AM -0600, Jonathan A. Kollasch wrote:
> The schematics[1][2] for both versions of the NanoPi NEO Plus2 place the
> STAT status LED on GPIOA10, and describe it as being a blue LED.
> 
> This change makes the blue status LED on my v1.0 board functional.
> 
> Signed-off-by: Jonathan A. Kollasch <jakllsch@kollasch.net>
> 
> [1]: http://wiki.friendlyarm.com/wiki/images/8/86/Schematic_NanoPi_NEO_Plus2-v1.0-1704.pdf
> [2]: http://wiki.friendlyarm.com/wiki/images/b/bf/Schematic_NanoPi_NEO_Plus2-v1.1-1805.pdf

URLs also have the tendency to become dead quite fast, while the git
history is here for ever, so it'd be better to avoid having them in
the commit message itself, but feel free to add them as reference
after the ---

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
