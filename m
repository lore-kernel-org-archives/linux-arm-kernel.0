Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353FFC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:39:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05EB220989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eSLxXx5q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yFyJ3xqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05EB220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1DQi+IxaEw9hUIZo3u8umSGe2/R2m1TpTyrqh86AnuA=; b=eSLxXx5qY+iwD0
	xHGPIRnu5xOwR2MIM5XGtkmq0cekWLSPMb8y5JWBX8zeyN2cGoHU3EAclVb3UN0x3StuMZcug89lf
	z/Djl7Y9MbFi7dEjq2tJoBfSNwgzI6D870liy3cIVRzb6scU9d0AgsGCfdB6rDFOkHePakO4pAA7O
	dCXH4BC5EtLvZaHn+jGOcUgfMqhm3MLAFzFdOyOY3INa3X7ebU20dhwsyiAt1aM86qZhnCFBkowUC
	Eho4rxODW2RN1GAS6hno2bCE7FCuQAmuwxmgc4CsCm7RXBYF4XNEZrUTnA3Xuw2W/DXAeLwU4aaep
	YfTcqfeITwtCb2zLM3fA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPM5-0003Ys-1d; Thu, 29 Nov 2018 16:39:57 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPM1-0003Xm-KX
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:39:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=pN8vz9NEBWTepb0s1vN1u+LUaOJEyOy8+uBDHRs3Lqs=; 
 b=yFyJ3xqB3DD8Jwcq2ugjxQlzHV+Q9ktu65Ludf55ZTm4nmxDz+rNXwV0YMKN59I7LPm6WAL6PLrdFxf03XGV4Yr1cl04TgJ6yOqwtqRL8pSwQYCwI3IWAce+nPmrEPNvTZyzXkXmVBC8Xebs12tJnB2m2m7BKrajXdPLUOE9Ybo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gSPLk-0000sR-Nd; Thu, 29 Nov 2018 17:39:36 +0100
Date: Thu, 29 Nov 2018 17:39:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: jacopo mondi <jacopo@jmondi.org>
Subject: Re: Regression: v4.20-rc4: "SMSC LAN8710/LAN8720: Master/Slave
 resolution failed"
Message-ID: <20181129163936.GE1501@lunn.ch>
References: <20181129144206.GK9807@w540>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129144206.GK9807@w540>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_083953_819244_E4B67A91 
X-CRM114-Status: UNSURE (   9.84  )
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
Cc: f.fainelli@gmail.com, netdev@vger.kernel.org, s.hauer@pengutronix.de,
 linux-kernel@vger.kernel.org, fabio.estevam@nxp.com, shawnguo@kernel.org,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 03:42:06PM +0100, jacopo mondi wrote:
> Hello,
>    netdev people,
>    i.MX6 people,
> 
>    I'm running an i.MX6Q system, and since v4.20-rc1 the ethernet PHY
> fails to properly startup, preventing me from mounting my NFS rootfs
> (the interfaces gets configured after some minutes, but it's too late
> for NFS).
> 
> The complete boot log:
> 
> [    3.000186] SMSC LAN8710/LAN8720 2188000.ethernet-1:00: attached PHY driver [SMSC LAN8710/LAN8720] (mii_bus:phy_addr=2188000.ethernet-1:00, irq=POLL)
> [    3.015616] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [    4.090582] SMSC LAN8710/LAN8720 2188000.ethernet-1:00: Master/Slave resolution failed, maybe conflicting manual settings?

Thanks for reporting this.

I made some changes in link mode handling. Let me check the code i modified.

  Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
