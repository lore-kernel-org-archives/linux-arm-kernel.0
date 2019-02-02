Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EB1C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:23:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5A82086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="olz3CT1F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="se9hoaNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5A82086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4KmStQlwXZz4iD8IGRIVPRm3XKU/ZFQoZaYdDocmPC8=; b=olz3CT1FbrFBzx
	e38iw5O9c9X9Lcfn62ArNJTpG6yws0Pi0Lb4E3/dzSqgQ7NkzCiqIIrr8Xls632C2s1NcxkfOD76x
	2uGVUVVJHcddxkok2Uh1MOLdMyfp0noo6RZtJB2s2n/iU21IQxOfS0AvMnl5v4aA1KgXnJ8Gs6dPE
	9dsR+Q8Rt7IEURCClDwddKyZhuboK89WgNxyBOv4nWQv6lKdjCrMFGr0n0mZWmU7wDb7LBCOQ35hD
	bXrHwrwokRKgAbNCn5KWpbAR6vqjzsdQm+1IFgpvKClUVWg/xvJstZjN/Fp22kW7Eoqj+LPu/UKfw
	D6XkW09m8FSH7mdoZtKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpvH0-0004Gr-2S; Sat, 02 Feb 2019 13:23:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpvGw-0004GQ-V0; Sat, 02 Feb 2019 13:23:52 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 653382173B;
 Sat,  2 Feb 2019 13:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549113829;
 bh=YYuVGPM0JmRr/Umuc+MgJly7841AA9DjCf5V59+o7Ac=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=se9hoaNHQ2E7qpQ4RKfZDAbyUs+bv2e+UQx+UgS9jh14h0ym6ZBgDUwFLiBiv1BA4
 6inOl6dlMW/yKZ6MNceWGJN0Rtga5JZNSbIGMuym3Fkz+J1icASXDPRygX7Fx1p92h
 EyZCeGIuz4tgZEb+E8nwKIwuEbYt9JdJzs6p2jNY=
Date: Sat, 2 Feb 2019 14:23:37 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v3 03/13] spi: atmel-quadspi: drop wrappers for iomem
 accesses
Message-ID: <20190202142337.3c51947e@bbrezillon>
In-Reply-To: <53c9f4b2-7022-e13d-65a4-2e1bed4d76b1@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-4-tudor.ambarus@microchip.com>
 <20190202081111.0bbc4443@bbrezillon>
 <53c9f4b2-7022-e13d-65a4-2e1bed4d76b1@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_052351_031151_910FD308 
X-CRM114-Status: GOOD (  18.68  )
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
 alexandre.belloni@bootlin.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Ludovic.Desroches@microchip.com, Cyrille.Pitchen@microchip.com,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 2 Feb 2019 08:44:27 +0000
<Tudor.Ambarus@microchip.com> wrote:

> On 02/02/2019 09:11 AM, Boris Brezillon wrote:
> > On Sat, 2 Feb 2019 04:07:19 +0000
> > <Tudor.Ambarus@microchip.com> wrote:
> >   
> >> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>
> >> The wrappers hid that the accesses are relaxed. Drop them.
> >>
> >> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >> v3: no change
> >> v2: new patch
> >>
> >>  drivers/spi/atmel-quadspi.c | 47 +++++++++++++++++++--------------------------
> >>  1 file changed, 20 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> >> index feeddcb25e1f..131374db0db4 100644
> >> --- a/drivers/spi/atmel-quadspi.c
> >> +++ b/drivers/spi/atmel-quadspi.c
> >> @@ -175,17 +175,6 @@ static const struct qspi_mode sama5d2_qspi_modes[] = {
> >>  	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
> >>  };
> >>  
> >> -/* Register access functions */
> >> -static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
> >> -{
> >> -	return readl_relaxed(aq->regs + reg);
> >> -}
> >> -
> >> -static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
> >> -{
> >> -	writel_relaxed(value, aq->regs + reg);
> >> -}
> >> -
> >>  static inline bool is_compatible(const struct spi_mem_op *op,
> >>  				 const struct qspi_mode *mode)
> >>  {
> >> @@ -229,6 +218,7 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
> >>  static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> >>  {
> >>  	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
> >> +	void __iomem *base = aq->regs;  
> > 
> > Can we name this variable regs instead of base or even get rid of it
> > and dereference aq->regs in the xxx_relaxed() calls (doesn't look like
> > the lines would be over 80 chars even when doing that). With this
> > addressed, you can add:
> > 
> > Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>  
> 
> I chose to introduce the "base" variable when I have at least 2 dereferences in
> a function, as an optimization. In exec_op() for example, there are 6
> dereferences of aq->reqs. Why do you prefer keeping aq->regs?

I tend to not add local variables unless they help improve readability
or optimize things. In this case, I'd expect the compiler to be smart
enough to detect that aq->reqs is used several times and store it in a
register. When it comes to readability, I don't think it improve
things, but that's probably a matter of taste.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
