Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E96C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:25:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F5A20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ebBoRae7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F5A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UF6aBoQP8E82MrV1aNydwIijoc5XLz+c3LOlKJccPmg=; b=ebBoRae7EKB3P7
	IyNyEdwc7oDK1EvPOT1V94hnDr+g52Rxr+B8Qm46a5pEuj+7zgJOa/u8Uf7lCw0HfVwwOfR6hq5q5
	4luUEBYUVn3Vm6iK34XisP8z9icN6JstEkH+IPNHxUgqKfY8ReeMK8pH7rIE63ED8v92nZWKhHjiN
	wfWEPlQ2YZc3WEYdceZO2iD9dCv+LKEN0tVnZTm4PUaSn6lzPpa/oYLmlx8vdeikBCAiKFZ1+I0vq
	XLjqzBcaonT8T/+MS9NNZJ87oZPOV5LvBdnxfcViSAWbxGN7o4hhrRWn6VtiuUjWdZDok/4Mtv8iO
	zMqNRQeAHRJIoREqNv8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlXF-0007pl-Lt; Thu, 21 Feb 2019 10:24:57 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwlXB-0007pM-VV
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 10:24:55 +0000
X-Originating-IP: 90.88.23.190
Received: from aptenodytes (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 322E94000B;
 Thu, 21 Feb 2019 10:24:47 +0000 (UTC)
Message-ID: <adbb183836e22dfc4558beaa818677c24bacf3a8.camel@bootlin.com>
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Michal Simek <michal.simek@xilinx.com>, Andrew Lunn <andrew@lunn.ch>
Date: Thu, 21 Feb 2019 11:24:47 +0100
In-Reply-To: <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
References: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
 <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com>
 <38f6708476e9beca4583ccc2a62e238a4981b735.camel@bootlin.com>
 <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
 <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
 <20190219172515.GC13075@lunn.ch>
 <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
Organization: Bootlin
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_022454_168867_33E44589 
X-CRM114-Status: GOOD (  18.95  )
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
 linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "David
 S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, 2019-02-20 at 07:58 +0100, Michal Simek wrote:
> Hi,
> 
> On 19. 02. 19 18:25, Andrew Lunn wrote:
> > > Thanks for the suggestion! So I had a closer look at that driver to try
> > > and see what could go wrong and it looks like I found a few things
> > > there.
> > 
> > Hi Paul
> > 
> > Yes, this driver has issues. If i remember correctly, it got merged
> > while i was on vacation. I pointed out a few issues, but the authors
> > never responded. Feel free to fix it up.
> 
> Will be good to know who was that person.
> 
> I can't do much this week with this because responsible person for this
> driver is out of office this week. That's why please give us some time
> to get back to this.

Understood. I think we need to start a discussion about how the general
design of this driver can be improved.

In particular, I wonder if it could work better to make this driver a
PHY driver that just redirects all its ops to the actual PHY driver,
except for read_status where it should also add some code.

Maybe we could also manage to expose a RGMII PHY mode to the actual PHY
this way. Currently, the PHY mode has to be set to GMII for the MAC to
be configured correctly, but the PHY also gets this information while
it should be told that RGMII is in use. This doesn't seem to play a big
role in PHY configuration though, but it's still inadequate.

What do you think?

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
