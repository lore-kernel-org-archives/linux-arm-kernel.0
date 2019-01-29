Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CECC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:06:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C43021871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iSwL0L54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C43021871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n+EWvaRkU30ugpKnclaGxeNI8CjYs8S65Ot261iY2yI=; b=iSwL0L54dDKXfQ
	W6b7NdRsend1AxXbHylTnh7r+RMOwasdkG/zpzeulBBoQgJTgldfxh3C7gP1V6/46CJp6nv75AKkc
	u0mbwBuDhQJri9D6FOf+2/yqdNlrvzNoNR2H2+VtssR+9AJKsnp+yPEEUdWvTBB274llir+PGU6pn
	OWPzoMTpL2wIsFAxRJmR0H5VoSyEHFh+ICXIEu48t7nMMDRamqcOYPqoZP8A0jDjr2OwF84uGa4tD
	gupmhq9hjwQoQDW2iKAm80Zdfyg2Ig7d/5tcbOFUXLba6WD9nE4GbQ1+1ebmKb8MzVu7W3ADXg+fx
	VPc0tGAj/T/JBrlBJv1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goUxp-00065Y-BT; Tue, 29 Jan 2019 15:06:13 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUxh-00064W-99
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:06:10 +0000
X-Originating-IP: 109.213.138.65
Received: from localhost (alyon-652-1-35-65.w109-213.abo.wanadoo.fr
 [109.213.138.65])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 866486001A;
 Tue, 29 Jan 2019 15:05:50 +0000 (UTC)
Date: Tue, 29 Jan 2019 16:05:49 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v4 2/2] spi-atmel: support inter-word delay
Message-ID: <20190129150549.GA19959@piout.net>
References: <20190129083844.20572-1-jonas@norrbonn.se>
 <20190129083844.20572-3-jonas@norrbonn.se>
 <995b3885-254b-7932-8d05-77271a2c070d@microchip.com>
 <7a6efd1a-5920-60e5-bc68-dfbe6866e522@norrbonn.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7a6efd1a-5920-60e5-bc68-dfbe6866e522@norrbonn.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_070605_467625_FC14CED1 
X-CRM114-Status: GOOD (  13.46  )
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
Cc: Tudor.Ambarus@microchip.com, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 29/01/2019 15:56:31+0100, Jonas Bonn wrote:
> On 29/01/2019 15:27, Nicolas.Ferre@microchip.com wrote:
> > On 29/01/2019 at 09:38, Jonas Bonn wrote:
> > > 
> > > +	/* DLYBCT adds delays between words.  This is useful for slow devices
> > > +	 * that need a bit of time to setup the next transfer.
> > > +	 */
> > > +	if (spi->word_delay_us) {
> > 
> > Well...
> > 
> > > +		csr |= SPI_BF(DLYBCT,
> > > +			clamp_t(u8,
> > > +				(as->spi_clk/1000000*spi->word_delay_us)>>5,
> > > +				1, 255));
> > 
> > ... why not simplifying to:
> > +				0, 255));
> > and remove the test altogether, after all?
> 
> Hmm... that seemed too easy!  This started out as something else and looking
> at it now I think even the clamp_t() is unnecessary.  The value is already
> 0-255 and the way SPI_BF works any overflow is already truncated...  I'll
> rework this and resubmit once I get some feedback on the word_delay_us bits.
> 

While at it, note that you need to add spaces around the operators.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
