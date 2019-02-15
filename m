Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D5AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:02:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6748921924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="flrKEzpS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="J8m8LJd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6748921924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n55K4A4kVQ265pa6lGjFEDHw1zs2sW7cgTGOtzkXtg0=; b=flrKEzpSmkv4kz
	iUr2B2taUovNk2FQDownAH1YFwnfER4Rrp7g//IxDnXLm90OXsQDF/5BGz3H1S8fnGohXgsOla5OI
	bidcqwFeirDk2rzVN8G4P7CBwsaRFBK8/ZmcefofgnSH5gpd7kL3mlEOoCYrLytKCDaIe5ZLwKlyG
	sznnuQgIDGLcoiCqkJE8qzM2AKHsXZNDQ+8AEdb9UeZzz2a2nTB4E3pu4RDAaTqwty0itVetvFwv3
	X6x9kiEQiuzn9L7iKiUj9YbLzgHjwLeqza0BTFyoZ/V3SINyTJ8TJeFuj1rf1O7UuC8jAKw5Ry7Kr
	WI5xoXftjj+YM/ZFPF2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugsU-00035I-Bs; Fri, 15 Feb 2019 17:02:18 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugs9-0002ob-PH
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:01:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Py2su8RzV13xDHnbmKHfqOETJQ5bPdnq2ClFAX+lQjw=; b=J8m8LJd318Ld2MdywzNqSjSZVT
 ZyDUYI7I4Uv7qtM2rzUyhv2gKrlRoWO5Rh2y6xOhAO36+SUrvrnoVt++L79T9Ki836US/OzKZcy3b
 Wdf5V9gZTgJmydjZP8KG+R9rWzCNl4tEp6q/M7THMtC27JsY66kE5iJdbgp6oeey0Q8M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gugs5-00085s-Gx; Fri, 15 Feb 2019 18:01:53 +0100
Date: Fri, 15 Feb 2019 18:01:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] net: phy: xgmiitorgmii: Support generic PHY status read
Message-ID: <20190215170153.GR708@lunn.ch>
References: <20190215161708.18645-1-paul.kocialkowski@bootlin.com>
 <20190215162344.GQ708@lunn.ch>
 <e8928afbb43cc8fffbb9b9034b2a94907fef596d.camel@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e8928afbb43cc8fffbb9b9034b2a94907fef596d.camel@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_090157_965753_3174C8E8 
X-CRM114-Status: UNSURE (   8.07  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> > How about using phy_read_status()?
> 
> Thanks fo rthe suggestion! Though I don't that would work here since
> our priv->phy_drv != phydev->drv, so it looks like we need to be
> breaking it down in the driver.

Ahm, yes. I forgot how this driver works.

     Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
