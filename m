From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Mon, 10 Feb 2014 12:35:13 +0100
Subject: [PATCH v4 4/7] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
In-Reply-To: <dac5ec28-3a6d-428f-8ab6-c8f2bb53168f@googlegroups.com>
References: <20140207212709.24624.58619.stgit@dizzy-6.o2s.ch>
 <20140207213316.24624.28705.stgit@dizzy-6.o2s.ch>
 <dac5ec28-3a6d-428f-8ab6-c8f2bb53168f@googlegroups.com>
Message-ID: <7779575.QASLIT4FqB@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
> > +            (cmd->opcode == 5 || cmd->opcode == 52))
> Aren't these the ones defined in linux/mmc/sdio.h:
> 5  - SD_IO_SEND_OP_COND
> 52 - SD_IO_RW_DIRECT
Yes. They are...
Changed that.
Also I removed the camel cases and the defines within the struct definition.

> > +struct sunxi_mmc_clk_dly {
> > +    u32 mode;
> > +    u32 oclk_dly;
> > +    u32 sclk_dly;
> Do these members have to be u32? They all seem to be smaller than 10.
Yes. Because of situations where it gets used in bit operations, and shorter
types mess things up and prevent the driver from working ;-)

cheer
david
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/8a8707bf/attachment.sig>
