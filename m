Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D0BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:32:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2040620859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V9rcG4IA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2040620859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xussOrGmiONUcvuEpoIbJzSh6t1XrLuYFsF29EiFujc=; b=V9rcG4IAyN4znc
	Y3K8IEdS5ARcG91HL2/C4BhW9j7TutTBAOzrp5LITzFjK/mWKLl5WrUXjkrK/QOX04DRkrjWil8XK
	w8hezzb0cY6zgHsXG4Ekwdn9YMg70zqJtQg6qlqhwJXgIk7kGcjk0cJxRSnl11fggsT9F0deqTkgp
	fRisLbFlDs0Q1okP+PJkf7p39fMvYpM3CsQAHKAUppae9ReehaJPNOPCIGJbAPlwntUmV0Ufirq3w
	zPwfQSwR06R+8fVdcVa0w5ogIZGs3jMQpwR7eVDqSzN/bc/7o1A6GWFa/0g3x5q2qJa/yQEVOFeK/
	bk4cOFhz6oI80FVj4xeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkDOi-0002b4-Uw; Thu, 17 Jan 2019 19:32:16 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkDOf-0002Zq-7o
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 19:32:14 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 8550A14B95546;
 Thu, 17 Jan 2019 11:32:07 -0800 (PST)
Date: Thu, 17 Jan 2019 11:32:06 -0800 (PST)
Message-Id: <20190117.113206.1061032640275399631.davem@davemloft.net>
To: f.fainelli@gmail.com
Subject: Re: [PATCH net-next 0/3] net: dsa: Split platform data to header file
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190115230613.28334-1-f.fainelli@gmail.com>
References: <20190115230613.28334-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Thu, 17 Jan 2019 11:32:08 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_113213_275345_409CF004 
X-CRM114-Status: UNSURE (   7.34  )
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
Cc: andrew@lunn.ch, jason@lakedaemon.net, arnd@arndb.de, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
 mchehab+samsung@kernel.org, akpm@linux-foundation.org,
 vivien.didelot@gmail.com, linux-kernel@vger.kernel.org,
 sebastian.hesselbarth@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 15 Jan 2019 15:06:10 -0800

> This patch series decouples the DSA platform data structures from
> net/dsa.h which was getting used for all sorts of DSA related
> structures.
> 
> It would probably make sense for this series to go via David's net-next
> tree to avoid conflicts on the ARM part, since we cannot obviously
> include a header that does not yet exist.
> 
> No functional changes intended.

Series applied, thanks Florian.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
