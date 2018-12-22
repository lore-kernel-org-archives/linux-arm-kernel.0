Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E83CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:32:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F91218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lNu7JdY0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="yKb7uN5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F91218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VbZggDPHdbTs7XH0JhFh+8wbVFiFHfF9vhz9V8MNkPo=; b=lNu7JdY0kQ1jRp
	UN+WTe9znvoGDCRsWOviA3bbX/hS5y03rmktJldrjX6aGYdtib/SvVjraLfOyw28RmjUKb3GyfC+6
	nD8xerEqg/2xrbGSS6qH1s274yjZ/ySqcQs7WiOI4drVeMCQM513P2+JJtkvy7UsLmjRsMrQPMSHP
	Mx6n0j/DWgnfMADfulKvi2FIKXvkC3nZBNR5N6pBsBl7z7sn0QZf/LqZEgYLvq8TbylKA9YOufcYH
	TtJMsUtBbpdUnOes0so8zLtho+eTM0d84r7TpaEBy0YHU7CHCOv+0EZ0n/rkUTrO/oL59+PdxgpAl
	lTJoVrk+QcXA3BL29D3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaX5w-0007XX-FX; Sat, 22 Dec 2018 02:32:52 +0000
Received: from mail.nic.cz ([2001:1488:800:400::400])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaX5f-000730-J1
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 02:32:39 +0000
Received: from localhost (unknown [172.20.6.218])
 by mail.nic.cz (Postfix) with ESMTPS id 66B4762921;
 Sat, 22 Dec 2018 03:32:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1545445939; bh=DVUaM5s/gkyyrDuwO8dMNt7yBZhE+5BJMFeRm8dxk20=;
 h=Date:From:To;
 b=yKb7uN5rYZl0gHYlqS80X1GJ8ilMdWkBkfaflcABVM6yYykNK1ooW044/ylQ2snjP
 5XQjs/2yWXrvGHtdyPhZDMmutCehy+jufr1QyDKAkSdIzEYbD2s2BoJJgAWn2tP3WK
 /lH12XapH+iHwMtsOxi9RhHdrLSTSDz+hPURzIeM=
Date: Sat, 22 Dec 2018 03:32:13 +0100
From: Marek Behun <marek.behun@nic.cz>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 1/3] pinctrl: armada-37xx: Correct mpp definitions
Message-ID: <20181222033213.43642e0f@nic.cz>
In-Reply-To: <20181221173259.8372-2-gregory.clement@bootlin.com>
References: <20181221173259.8372-1-gregory.clement@bootlin.com>
 <20181221173259.8372-2-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_183236_326257_4C9F8B1A 
X-CRM114-Status: UNSURE (   6.18  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, linux-gpio@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 21 Dec 2018 18:32:57 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> +	PIN_GRP_GPIO("pcie1", 3, 1, BIT(5), "pcie"),
> +	PIN_GRP_GPIO("pcie1_clkreq", 4, 1, BIT(9), "pcie"),

If the pair is split to clkreq and reset, shouldn't the first be called
pcie1_reset?
Marek

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
