Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1FFC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:37:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1ABD2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QlH7hFwd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9wcUqx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1ABD2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zjHIFxZ04+joWiezH87iVQKpByQTV6IN7drrD6F6858=; b=QlH7hFwdAROAEa
	dEtncsS4ijfm9/D5++vLWod9qb1imNZYq4hA/c2lo/R4hZ5ALsFBNoscikXbfOh/ZaC/TpscvxGaS
	n3jkb8kZieM35mov9noHEiTJ4JNB98NiOtWMtES5kzOStpv97GbANyH63InBfvCrHkES+1zpq4aO4
	y6b93SJyoGfVoNrcgPfXvgRVBjI5aDSMmKqM7rFNLYsQ02RG19SHa8lMN7VgDzI+uVxP0tt9PvzO9
	B3wFbMMXZ+RNx4DTm0BNAd0pgNCvWlqFmzxD2Ce1h9qAMFGwtOZYDFmQHG6nKlpmFKoGQxW3Gx2t7
	clyxwR1iYl4t75TpLRAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqfND-0006Fa-Ut; Mon, 04 Feb 2019 14:37:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqfNA-0006FD-PF; Mon, 04 Feb 2019 14:37:22 +0000
Received: from bbrezillon (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D45D02083B;
 Mon,  4 Feb 2019 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549291040;
 bh=AvnNVAT8ciem9UZ+hOBYnQRHq5c1WtwKWaoN/SqJE1o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=W9wcUqx16D0Z44oXAovv0qLuy8bpGQs+aMSlqCZXzffcFJmKWlBUjK5ogbIGVwKg0
 g8MtQN46FSizXq4NUpNzF3mDpNvCbEJ5oL1BBmN8yk98YCq+3AteWrUZbeP/yTS5H+
 eigbPgDylxQsz8W2VCwWZwQMPKiLCAZhXxajmkmg=
Date: Mon, 4 Feb 2019 15:37:13 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v4 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Message-ID: <20190204153713.2fd02769@bbrezillon>
In-Reply-To: <25f6ee72-e6e1-7014-6e4b-abe0a1a0eebc@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
 <20190204100910.26701-14-tudor.ambarus@microchip.com>
 <20190204151643.0354180d@bbrezillon>
 <25f6ee72-e6e1-7014-6e4b-abe0a1a0eebc@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_063720_837343_84869859 
X-CRM114-Status: GOOD (  12.03  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 Cyrille.Pitchen@microchip.com, robh+dt@kernel.org, linux-spi@vger.kernel.org,
 Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 4 Feb 2019 14:28:27 +0000
<Tudor.Ambarus@microchip.com> wrote:

> >   
> >> +	writel_relaxed(cfg->ifr, aq->regs + QSPI_IFR);
> >> +}  
> > 
> > Hm, so the only difference we have is the RICR vs ICR reg and the
> > APBTFRTYP_READ vs SAMA5D2_WRITE_TRSFR bit. Not sure it deserves
> > creating 2 hooks for that. Can we have something like ->has_ricr in
> > the caps and then have an if/else block directly in
> > atmel_qspi_set_cfg()?
> >   
> 
> Correct. It is a cost of an extra if, I tried to avoid it. I like it better with
> these two hooks, but if you have a strong opinion I'll do it, just confirm it again.

The cost of an indirect call is actually higher than an extra if/else
block. I'm not against paying this extra cost when implementations are
completely different, but that does not seem to be the case here.
Moreover, if you get rid of these hooks, you can also get rid of the
cfg struct.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
