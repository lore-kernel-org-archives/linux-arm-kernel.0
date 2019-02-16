Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11366C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:21:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7BC21929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AsN9lpM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7BC21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dpQOE8s+zviL8uHyi75NlyttTxRQt+BWZQdgcW0BhhY=; b=AsN9lpM9glu4mD
	cfF6eskeAJoFrzZi7H+VaVYJYjxg8I496oJvocUJ58SBqpc51P1TaS3Zo3+hlH5/qsLU/05/LXn/l
	HiPIS9YpvmNLZEr1lnyEEIBdwD7hzwXxlgXUw0TErt6r95ibsLYbazsL9oNLhV/9mnb7NyB7OjH8S
	eW0YMNNWsI8lqsTAcLEJBxaAE5+y+zGOuJEcaFe8ox+dGfR4frC+IED3DLNTKWv8xIbGv40LpIBnr
	czzYTIsBbs9ErYQIZd55Q+9NlZkJptgAFaxZ69pYJQceAHQRsC9JwDsSjM6sws0JjmCjIvkkohq8w
	ux2nHmKAB5lY9Y1gNPgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gurU2-0008R5-VY; Sat, 16 Feb 2019 04:21:46 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gurU0-0008QS-FS
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 04:21:45 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 280B8106FCBE0;
 Fri, 15 Feb 2019 20:21:39 -0800 (PST)
Date: Fri, 15 Feb 2019 20:21:38 -0800 (PST)
Message-Id: <20190215.202138.1915616474041185856.davem@davemloft.net>
To: paul.kocialkowski@bootlin.com
Subject: Re: [PATCH] net: phy: xgmiitorgmii: Support generic PHY status read
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190215161708.18645-1-paul.kocialkowski@bootlin.com>
References: <20190215161708.18645-1-paul.kocialkowski@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Fri, 15 Feb 2019 20:21:39 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_202144_514274_05EDFD53 
X-CRM114-Status: UNSURE (   7.75  )
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
Cc: andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 hkallweit1@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Date: Fri, 15 Feb 2019 17:17:08 +0100

> Some PHY drivers like the generic one do not provide a read_status
> callback on their own but rely on genphy_read_status being called
> directly.
> 
> With the current code, this results in a NULL function pointer call.
> Call genphy_read_status instead when there is no specific callback.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks.

Unfortunately I only noticed your updated version with the Fixes tag
after pushing this version out.  I'll be more careful next time :)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
