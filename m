Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D2BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:28:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D4F20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="paUfFMr8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp1wr5/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D4F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xFI0g/GRxaKKZNUhv7qr+jorQ3gjJSZvAhaW2sL98j4=; b=paUfFMr8TcbQwT
	awqc3JdvX1YuaBaNTuVZNEwE2LJZxy73aGiEqN4c7z+8Ii90LTTvcAOLgxbTqTbxv9GFu6TSwAjce
	n75+ju4qJuy4TtYn7vZjpd6aQ3niZDX1rTTX6AvJ0Ca00Mxi8BCsIhYF+cSUrGb6J37UIL0FY+W0g
	JCB2tKNFj613QWcx7ipxVR0oVwBbMa4/mY9Oh0Bf6J2YO1gUgGNclhwEVAOTCkV8pELPtwxO9hlyL
	fhbxd8CqqT3sTBFOafmQn36KpgHW6me44ajn3TpvQR3HaiU1z7/mqzH9hWj02Rgdojm3PM1ngpsk4
	q16KcI8aMGDmu/7ma1cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpvKr-0006A1-CH; Sat, 02 Feb 2019 13:27:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpvKo-00069d-En; Sat, 02 Feb 2019 13:27:51 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 711E520869;
 Sat,  2 Feb 2019 13:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549114070;
 bh=l1pN7fuz+BKbmI/D8YM/7srSCmBdVjJ27CH/CyauKFo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Xp1wr5/CWTOk7dRloeQtPVWS+lwH0Rq2t+VPVYyR97WS4VUo8FBuI6F0sVWDhi3Mq
 h+lPmTz/lxA5jHfAGdNtG1IbmTZ8ixIln3JZWaI6GE4h2ehpA7F0Mqswv4W3l5j9sk
 3jSJfl0RmftkaKTLNmssKDPkbGgUCLfIpR3NBKCI=
Date: Sat, 2 Feb 2019 14:27:36 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v3 08/13] spi: atmel-quadspi: drop unused and NOP
 transfer macros
Message-ID: <20190202142736.5d723ed6@bbrezillon>
In-Reply-To: <0e266a16-2f84-e1c3-440f-55105dd0c0be@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-9-tudor.ambarus@microchip.com>
 <20190202081338.01056dce@bbrezillon>
 <0e266a16-2f84-e1c3-440f-55105dd0c0be@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_052750_512614_640C52DD 
X-CRM114-Status: GOOD (  14.39  )
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

On Sat, 2 Feb 2019 08:46:38 +0000
<Tudor.Ambarus@microchip.com> wrote:

> On 02/02/2019 09:13 AM, Boris Brezillon wrote:
> > On Sat, 2 Feb 2019 04:07:33 +0000
> > <Tudor.Ambarus@microchip.com> wrote:
> >   
> >> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>
> >> Remove NOP when setting read transfer type. Remove useless
> >> setting of write transfer type when
> >> op->data.dir == SPI_MEM_DATA_IN && !op->data.nbytes.
> >>
> >> QSPI_IFR_TFRTYP_TRSFR_WRITE is specific just to sama5d2 qspi,
> >> rename it to QSPI_IFR_SAMA5D2_WRITE_TRSFR.
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >> v3: new patch
> >>
> >>  drivers/spi/atmel-quadspi.c | 12 +++---------
> >>  1 file changed, 3 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> >> index d26d4cd0e36b..bfa5f5e92d96 100644
> >> --- a/drivers/spi/atmel-quadspi.c
> >> +++ b/drivers/spi/atmel-quadspi.c
> >> @@ -113,11 +113,7 @@
> >>  #define QSPI_IFR_OPTL_4BIT              (2 << 8)
> >>  #define QSPI_IFR_OPTL_8BIT              (3 << 8)
> >>  #define QSPI_IFR_ADDRL                  BIT(10)
> >> -#define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
> >> -#define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
> >> -#define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
> >> -#define QSPI_IFR_TFRTYP_TRSFR_WRITE     (2 << 12)
> >> -#define QSPI_IFR_TFRTYP_TRSFR_WRITE_MEM (3 << 13)
> >> +#define QSPI_IFR_SAMA5D2_WRITE_TRSFR	BIT(13)  
> > 
> > Can you define QSPI_IFR_TFRTYP_MEM (bit 12) even if it's not used yet?  
> 
> Shouldn't be introduced with the dir map support?

I like when all regs/reg-fields are defined, even if they're not used.
In this case, you're cleary splitting the TFRTYP_TRSFR_ bitfields in 2:
one bit encoding the mem/reg transfer type and one bit encoding the
direction of the transfer (read/write). Just think it's better to add
bit 12 definition now.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
