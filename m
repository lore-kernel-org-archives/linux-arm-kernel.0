Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7485FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:25:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9FE2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hoh/NyWk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XtTN5cGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9FE2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CNwavxndy+UWZICvWuO7teoz9kDU2NMWyiEPNrtIJ9M=; b=Hoh/NyWkBkZhp1
	XUdqCECZNdNgNYLDvxnh9sXg3JLjk3ArTJUdb2UKtnOfe+tVM2CYUwxUSDiVVTDW5XSTmNqztowJm
	FzWQLhq66iBaDBF5lPW5YSyZKLLadng5tPAMa9kEUmPPJcHQ4sApe66OTcwZqeeWYYz7CTI9gBNq6
	L4HUv+2X8ioySteTZGaXK94TBs1cyvzQJ1QKE3PQUb7eUX3t8GtNIwZ9DnMz057/9uTjFp5amih4f
	1L+sTgkjSOtocFIU01lwJnLxYIvuCDRHK9gUOlS2w0stQKExWtj/p+9lRM+Y13UcZ2LWPQhEtqAvF
	ZqpY2CZypJEk4erTMw0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw991-0004JQ-W0; Tue, 19 Feb 2019 17:25:23 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw98y-0004J3-VW
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 17:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LnvyGOgjbYVLRVfBv50PQAnCAvcPo714q4+V/Tj3lPI=; b=XtTN5cGTUZp/UrCmN0lXD5AJ5C
 aMg2IHbXdsyABQdEMlHJj2Wr7VBCxmS5UDXVxLzh2PzgqBpQ1Rvc9noH3H+3rZfd2FCPAFu3KuQM1
 oJgIkop+FF/fbMAQVRwVCkvrPO7rdMgm5EhfkqH2G1y1JSvYM+EGsu1IgBjmpJ0QNFcs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gw98t-0004TM-L7; Tue, 19 Feb 2019 18:25:15 +0100
Date: Tue, 19 Feb 2019 18:25:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
Message-ID: <20190219172515.GC13075@lunn.ch>
References: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
 <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com>
 <38f6708476e9beca4583ccc2a62e238a4981b735.camel@bootlin.com>
 <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
 <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_092521_171924_684C341E 
X-CRM114-Status: UNSURE (   8.51  )
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

> Thanks for the suggestion! So I had a closer look at that driver to try
> and see what could go wrong and it looks like I found a few things
> there.

Hi Paul

Yes, this driver has issues. If i remember correctly, it got merged
while i was on vacation. I pointed out a few issues, but the authors
never responded. Feel free to fix it up.

      Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
