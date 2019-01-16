Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98576C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:29:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6929520840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wbnsst5/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QEl3yvE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6929520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dbGMYclQlRw3hgGVNA2Ru3AMf9tJnafkagl/6E0npLA=; b=Wbnsst5/xGndQm
	IjxaPrHQcR5F54CvQvw8FO108jBVZOUN9xejkVT9lbgfnaeIQeXj849UoWdnG+6AYeD2Ss3t8YslN
	+Av9rMfRlwn+/3SXtQw/uxDt9E7Kiv2fiYxl4tQ87Q6oi3Wt7B5GidLLezu2PC5RemNKK1l99tFKZ
	QOcfEqV1fFffi9AxakewKrBWuDEffqJ24cvtNCK5avR3rI4xWP0YtSAuQ9w8pmygUbh/+GN5h5oi/
	Zdjd7XQxjGhbTxmN3/bWYh3lRtY6kWQgTUMWGXDYrXSmPEXBOATYJDsRa+pI7LJHcpmCjvkrechlx
	uwIUqTL1f/oSvzPrG4Gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjth2-0006r7-Sj; Wed, 16 Jan 2019 22:29:52 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjtgy-0006qD-V3
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 22:29:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=tUtj6epF5DgvzpzF9MzvHfabAc2wUY/RetBvPZWfBQE=; 
 b=QEl3yvE3ZFrMYZu9bz5eQ9FvBSMKLd0vn4gqIuSoe4jFFR9Xw3WsXeM7KcEcVHolUtNqarIJPEQZTPtGe0Q4Zo2hF7Sfk9cmtFMbtHw/corfPQnDa7qskw/NbA1WFt8NHgsZrxl+1Ntme+yiTDJy/2FXqBXAcP4WsP52mPIEKw4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gjtgn-00030B-Bw; Wed, 16 Jan 2019 23:29:37 +0100
Date: Wed, 16 Jan 2019 23:29:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 1/3] net: dsa: Split platform data to header file
Message-ID: <20190116222937.GR29244@lunn.ch>
References: <20190115230613.28334-1-f.fainelli@gmail.com>
 <20190115230613.28334-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115230613.28334-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_142949_150871_AC324F99 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: open list <linux-kernel@vger.kernel.org>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>,
 Russell King <linux@armlinux.org.uk>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 "moderated list:ARM/Marvell Dove/MV78xx0/Orion SOC support"
 <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index b3eefe8e18fd..6178b648d08a 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -21,6 +21,7 @@
>  #include <linux/ethtool.h>
>  #include <linux/net_tstamp.h>
>  #include <linux/phy.h>
> +#include <linux/platform_data/dsa.h>
>  #include <net/devlink.h>
>  #include <net/switchdev.h>

Hi Florian

Could there be one more patch at the end which removes this?  I think
it is here just as an intermediary step?

Thanks
	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
