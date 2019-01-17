Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32413C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:17:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF834205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U4gzTakG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M6uvh3es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF834205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C3a2eFm4bFYipgQimFoXVZ2n8bRwDTtU0lKDzynhK2s=; b=U4gzTakGLqlZYY
	rzGpiAMmg5fD3PEkBLNc3edNnAnuj2uEnv2bRqi2KXobRxdGJJVIInmqKN+b9VVWChurfHy+u2O+K
	Lq35Eey9rudF/aCOt+AS7UWpIl0HhOYHH4f+xYqIQKyznXrcSKNGjM8rw0/KO7IilYwm2PLNp5WlB
	xmUJ2KydSF8T/yivq9Sn5GeTSKFXD7Wl9CiV1IFTEU/bGkFxRJIeCNi4Ji1A1Ld+AdNPQ14DFyTbS
	v9nuoToYta36SRN3vPeaYWmwudEr19tEh+Lc3PydC1k50vLvV6ohtHxSC2w6KcBEHk37FinxcLuI8
	d7uYaAnExb5FYp/9nhwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjwJ7-0003SF-Pu; Thu, 17 Jan 2019 01:17:21 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjwJ4-0003Qw-89
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 01:17:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=ec9bbF8OL5VY7UwciWCsOzol94m4fzB9Wgbp8k+25c8=; 
 b=M6uvh3esomrz1fZgWOgwkOBV9danA9pHxvDErnZu4+OswQiPOzR3zPZ135/WMYJ3ByGzwViFTM0MUpZ9PnCZrW+W3GVZAz5B3PrTzCergKNeaLDK2ZBpEPGSflWKwsAAZXuLTpyzg4gAMlJbSU1nF5d8YGT2gwaGufgzaRJ1P1M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1gjwIw-00049I-5a; Thu, 17 Jan 2019 02:17:10 +0100
Date: Thu, 17 Jan 2019 02:17:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 1/3] net: dsa: Split platform data to header file
Message-ID: <20190117011710.GI24870@lunn.ch>
References: <20190115230613.28334-1-f.fainelli@gmail.com>
 <20190115230613.28334-2-f.fainelli@gmail.com>
 <20190116222937.GR29244@lunn.ch>
 <6f593b8b-5bb7-f884-d1d6-d509fd794419@gmail.com>
 <1a738e85-6a35-5cb3-3069-8d876724b716@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a738e85-6a35-5cb3-3069-8d876724b716@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_171718_459405_55A1D5E2 
X-CRM114-Status: GOOD (  14.87  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Russell King <linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 "moderated list:ARM/Marvell Dove/MV78xx0/Orion SOC support"
 <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 03:50:44PM -0800, Florian Fainelli wrote:
> On 1/16/19 3:06 PM, Florian Fainelli wrote:
> > On 1/16/19 2:29 PM, Andrew Lunn wrote:
> >>> diff --git a/include/net/dsa.h b/include/net/dsa.h
> >>> index b3eefe8e18fd..6178b648d08a 100644
> >>> --- a/include/net/dsa.h
> >>> +++ b/include/net/dsa.h
> >>> @@ -21,6 +21,7 @@
> >>>  #include <linux/ethtool.h>
> >>>  #include <linux/net_tstamp.h>
> >>>  #include <linux/phy.h>
> >>> +#include <linux/platform_data/dsa.h>
> >>>  #include <net/devlink.h>
> >>>  #include <net/switchdev.h>
> >>
> >> Hi Florian
> >>
> >> Could there be one more patch at the end which removes this?  I think
> >> it is here just as an intermediary step?
> > 
> > Yes, we can have only dsa2.c and legacy.c include that file from there
> > on, I will resubmit with that change, thanks!
> 
> We actually need to keep that include in there, because we use
> DSA_MAX_SWITCHES in net/dsa.h and splitting that define away could be a
> bit tedious since it is used by dsa_platform_data which was exposed before.

Hi Florian

O.K, so lets keep the patchset as it is.

Thanks
	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
