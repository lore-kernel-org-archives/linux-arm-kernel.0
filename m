Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4420AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:34:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139F32184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eW4tSCF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139F32184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/78vJEbytFgJBUhl40r4YJ3kTcQEeBspx5SZK2QtK64=; b=eW4tSCF2kbRsfL
	GkrwIvJUHyzCJ6ydogv3BgabN0calpYEIIOezHFsMjMnXwZh0Erh8ATz+WUEApMfDvFpXHUmUnKOc
	XBdRviZQ4EnzrN0Ec2PkltjbQWAW09I0pnWv26hK3pFgbRfGqnFQ9ccZa27m9pRJUjoTWpyJKzWEC
	s8xt6LC7PiHgVTiZ2q2sG/F1zP5BZq3Ho8fQdaRN1mebLbxgxL2Z9+Kv/WtMoBCMsMcGZ6ZOe7iwO
	5B10cgTaAG+KAbFIDt4xZkjvUGY+3+XdxRmk7Ru6+LYdSZeSyBzVqCnneP0ask12Nk+PhKPNtl53l
	o3Rc0LPwlc5jfzgdcwqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvVx2-0004tq-D6; Sun, 17 Feb 2019 23:34:24 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvVwz-0004t1-BR
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 23:34:22 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id AEEFE12294510;
 Sun, 17 Feb 2019 15:34:13 -0800 (PST)
Date: Sun, 17 Feb 2019 15:34:13 -0800 (PST)
Message-Id: <20190217.153413.776181738897663074.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next] net: phy: marvell10g: Don't explicitly set
 Pause and Asym_Pause
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190215083347.5886-1-maxime.chevallier@bootlin.com>
References: <20190215083347.5886-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Sun, 17 Feb 2019 15:34:14 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_153421_392505_5FB60F36 
X-CRM114-Status: UNSURE (   6.24  )
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
Cc: andrew@lunn.ch, f.fainelli@gmail.com, antoine.tenart@bootlin.com,
 netdev@vger.kernel.org, gregory.clement@bootlin.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, linux-arm-kernel@lists.infradead.org,
 hkallweit1@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Fri, 15 Feb 2019 09:33:47 +0100

> The PHY core expects PHY drivers not to set Pause and Asym_Pause bits,
> unless the driver only wants to specify one of them due to HW
> limitation. In the case of the Marvell10g driver, we don't need to set
> them.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
