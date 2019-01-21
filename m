Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866D4C3713C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:03:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519062089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pkLFulzZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="CQteFF3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519062089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4GdYGCmOCz3386rOoHQHp27gVRds2j6G8UIuPKeDrtg=; b=pkLFulzZmzPboy
	TG8AozNlpaDWkKEipjLvyTqe7uZJrnopSe9kMadJFLNyrU7bfH/U03gDxk6Yv73H+FY+mmXK1i2Md
	bDGUx2ZWNbgOMVPnlk+H1zBJ+g+IfcPONtsPZydwbOYPGnbdy+QXESHkSs2wx2lIuheTbLcXJRKvA
	Pl8pqBTo2ZgZOdQ6vBx0fHgCgKbpq9Et0gVOyNdPxk9LxhNh0SFQ8qm37xbW7wL7OqiqCBwTUtTlI
	j43sn+bQ2PJv9jf3ktQiBXq1PnmlgSL1xf8QRQnjRMhquegVGVFztl3KKk3R8hzZlGaO9Lzi4ezQw
	moPZInFPEIFwCimttbPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glhfa-00051T-1u; Mon, 21 Jan 2019 22:03:50 +0000
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glhfV-00050u-Er
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 22:03:48 +0000
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0A30C806B7;
 Tue, 22 Jan 2019 11:03:22 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1548108202;
 bh=G/32QpsGo6AFzQcVyNK2GChIpMKMjYacMxXz4BGbi+w=;
 h=From:To:CC:Subject:Date:References;
 b=CQteFF3caP5dbpHbj3cLofbmL4phiah55cVGnMHkmgNsUkABUytFWykP3xQBEzBMs
 HKnnVzYONv6TtUSk9oNVsK9c5ZmR0cw4ebjJP4X2Tz9WG75cTqPF8VmzCLNVQEUqQA
 ZPlsCOjk5YOhlx8npNaA0xhqC8mwIEoa1TzzTknXglfNp1Dw36nyKrANpShMG3VHZV
 psXq0iS0h6FKn2XY+AaKHk76JcJIWNFZO/W84mw2ldENv57RhL/19ME8KkbOjH5U7N
 GquuWqU5rJy7t2nE73CUjiTrHR6vZMiZtKc1cXSoycomt4GJzqeL5mk2VIfcZ07C9n
 pJLzit9ntiaWA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by
 mmarshal3.atlnz.lc with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c4641aa0000>; Tue, 22 Jan 2019 11:03:22 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Tue, 22 Jan 2019 11:03:21 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Tue, 22 Jan 2019 11:03:21 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bp@alien8.de"
 <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>, "jlu@pengutronix.de"
 <jlu@pengutronix.de>, "gregory.clement@bootlin.com"
 <gregory.clement@bootlin.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 0/9] EDAC drivers for Armada XP L2 and DDR
Thread-Topic: [PATCH v7 0/9] EDAC drivers for Armada XP L2 and DDR
Thread-Index: AQHUgfgBrJjSADzRCEun9Iucv3y9fg==
Date: Mon, 21 Jan 2019 22:03:21 +0000
Message-ID: <f40952f1bc7b4a209328b1213fd517b1@svr-chch-ex1.atlnz.lc>
References: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.10]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_140346_006234_B60C8411 
X-CRM114-Status: GOOD (  18.41  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi All,

On 22/11/18 1:12 PM, Chris Packham wrote:
> The current plan is for these to go in via the ARM tree once appropriate
> Reviews/Acks have been given
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-August/525561.html

Is there anything I need to be doing to move this series along? It seems 
to have dropped off the radar.

> 
> This series adds drivers for the L2 cache and DDR RAM ECC functionality as
> found on the MV78230/MV78x60 SoCs. Jan has tested these changes with the
> MV78460 (on a custom board with a DDR3 ECC DIMM), Chris has tested these
> changes with 88F6820 and 98dx3236 (both a custom boards with fixed DDR3 + ECC).
> 
> Also contained in this series is an additional debugfs wrapper.
> 
> Compared to the previous v6 series I've dropped the marvell,ecc-disable
> property.
> 
> Compared to the previous v5 series I've split the dt-binding documentation into
> its own patch and updated armada_xp_edac.c to use a SPDX license.
> 
> Compared to the previous v4 series I've added my s-o-b to some of Jan's
> patches and rebased against v4.19.0.
> 
> Compared to the previous v3 series, the following changes have been made:
> - Use shorter names for the AURORA ECC and parity registers
> - Numerous formatting changes to edac/armada_xp.c (as requested by Boris)
> - Added support for Armada-38x and 98dx3236 SoCs
> 
> Compared to the previous v2 series, the following changes have been made:
> - Allocate EDAC structures later during probing and drop devres support
>    patches (requested by Boris)
> - Make drvdata->width usage consistent according to the comment (suggested by
>    Chris)
> 
> Compared to the previous v1 series, the following changes have been made:
> - Add the aurora-l2 register defines earlier in the series (suggested by
>    Russell King and Gregory CLEMENT )
> - Changed the DT vendor prefix from "arm" to "marvell" for the ecc-enable/disable
>    properties on the aurora-l2 (suggested by Russell King)
> - Fix some warnings reported by checkpatch
> 
> Compared to the original RFC series, the following changes have been made:
> - Integrated Chris' patches for parity and ECC configuration via DT
> - Merged the DDR RAM and L2 cache drivers (as requested by Boris, analogous
>    to fsl_ddr_edac.c and mpc85xx_edac.c)
> - Added myself to MAINTAINERS (requested by Boris)
> - L2 cache: Track the msg size and use snprintf (review comment by Chris)
> - L2 cache: Split error injection from the check function (review comment by
>    Chris)
> - DDR RAM: Allow 16 bit width in addition to 32 and 64 bit (review comment by
>    Chris)
> - Use of_match_ptr() (review comments by Chris)
> - Minor checkpatch cleanups
> 
> Chris Packham (4):
>    ARM: l2x0: support parity-enable/disable on aurora
>    dt-bindings: ARM: document marvell,ecc-enable binding
>    ARM: l2x0: add marvell,ecc-enable property for aurora
>    EDAC: armada_xp: Add support for more SoCs
> 
> Jan Luebbe (5):
>    ARM: l2c: move cache-aurora-l2.h to asm/hardware
>    ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
>    ARM: aurora-l2: add defines for parity and ECC registers
>    EDAC: Add missing debugfs_create_x32 wrapper
>    EDAC: Add driver for the Marvell Armada XP SDRAM and L2 cache ECC
> 
>   .../devicetree/bindings/arm/l2c2x0.txt        |   1 +
>   MAINTAINERS                                   |   6 +
>   .../asm/hardware}/cache-aurora-l2.h           |  50 +-
>   arch/arm/mm/cache-l2x0.c                      |  18 +-
>   drivers/edac/Kconfig                          |   7 +
>   drivers/edac/Makefile                         |   1 +
>   drivers/edac/armada_xp_edac.c                 | 635 ++++++++++++++++++
>   drivers/edac/debugfs.c                        |  11 +
>   drivers/edac/edac_module.h                    |   5 +
>   9 files changed, 730 insertions(+), 4 deletions(-)
>   rename arch/arm/{mm => include/asm/hardware}/cache-aurora-l2.h (50%)
>   create mode 100644 drivers/edac/armada_xp_edac.c
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
