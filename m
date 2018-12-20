Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA84CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:45:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BB621720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gHsmQHlP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="r9yGH3Vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BB621720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RjG02Z4dEtXJRybTZyFGMxEpvfX/QxsB/gKBvDn0BW4=; b=gHsmQHlP2unohL
	hEeOl5818rjwkHz6SxAuKwjeDGuFhMNstM52JWHrZwK8oQdbCJvHjl2yI591Fhb4FdahoGOuEB8eP
	gA+obaSSPAzu43IWQsqVQghpaUmqHdkC1ti0/Gn0AY8/YrM63qiAR9xK8/05+bd66W0IQ+EbaihHM
	t919hm4YrxFuQUSP59DZUAqd0gCbjdYNCpvygNBai4/r6HD49MLLhppdI2OJtXoi0pcw1Y+ZtdVzT
	hoFucVMj7xtInO9UqttSaH1TnsokbO4uNe45fYTOdpNiAJ0i+EaKuW6PzamnrXIO66xoNJFaAR2VX
	E5O5TLsrpeBEmHvBmquw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZt0r-0006ea-PU; Thu, 20 Dec 2018 07:44:57 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZt0o-0006dr-5w
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 07:44:55 +0000
Received: from penelope.horms.nl (softbank060150141248.bbtec.net
 [60.150.141.248])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 58E5125B7E1;
 Thu, 20 Dec 2018 18:44:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1545291879; bh=htEIxwKQ/3waHarpYN9r5kNKzF3FEGgoZ2SOrKIGuJY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r9yGH3VbPTCtgaKg82s0f8yDnr4lPvyLDh9QksEYrF/XTZtNlLW01URl4yhibZLnh
 /v+lgL4KAWirmsay/gKzjTaBpUAWZnsiHzA3Y6ld1CZ8ITYNLV5Az2x/MoSNvqgDw8
 t+2F0p6rZmShaWgofmJ1oA6eiv/TLXsMbZnoKoqc=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id C2FAAE218FB; Wed, 19 Dec 2018 23:44:37 -0800 (PST)
Date: Thu, 20 Dec 2018 16:44:37 +0900
From: Simon Horman <horms@verge.net.au>
To: DUNG NGUYEN <dung.nguyen.aj@renesas.com>
Subject: Re: [PATCH] ARM: shmobile: Fix R-Car Gen2 regulator quirk
Message-ID: <20181220074437.44iq7n656tyqd5tt@verge.net.au>
References: <20181207202858.17129-1-marek.vasut+renesas@gmail.com>
 <TY2PR01MB369237F587AA0FF04484E421D5BF0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <TY2PR01MB369237F587AA0FF04484E421D5BF0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_234454_411724_9D004A52 
X-CRM114-Status: GOOD (  18.08  )
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 05:01:15AM +0000, DUNG NGUYEN wrote:
> > The quirk code currently detects all compatible I2C chips with a shared IRQ line
> > on all I2C busses, adds them into a list, and registers a bus notifier. For every
> > chip for which the bus notifier triggers, the quirk code performs I2C transfer on
> > that I2C bus for all addresses in the list.
> > The problem is that this may generate transfers to non-existing chips on
> > systems with multiple I2C busses.
> > 
> > This patch adds a check to verify that the I2C bus to which the chip with shared
> > IRQ is attached to matches the I2C bus of the chip which triggered the bus
> > notifier and only starts the I2C transfer if they match.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > ---
> Hi Mr Marek
> 
> Tested-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
> 
> I have tested this patch on H2 Lager with mainline v4.20-rc4 kernel.
> Confirmed that the problem is improved by this patch.
> 
> Best regards,

Thanks, applied for v4.22.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
