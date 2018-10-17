From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed, 17 Oct 2018 09:10:45 +0200
Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
In-Reply-To: <20181017090724.12f2cd79@bbrezillon>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
 <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
 <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
 <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017090724.12f2cd79@bbrezillon>
Message-ID: <20181017091045.124e0266@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Oct 2018 09:07:24 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Wed, 17 Oct 2018 02:07:43 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > >     
> > Actually there is no entry of s25fs512s in current spi-nor.c file.
> > For my connected flash part, jedec ID read points to s25fl512s. I
> > have asked my board team to confirm the name of exact connected flash
> > part. When I check the data sheet of s25fs512s, it also points to the
> > same Jedec ID information. { "s25fl512s",  INFO(0x010220, 0x4d00, 256
> > * 1024, 256, ....}
> > 
> > But as stated earlier, if I skip reading SFDP or read using 1-1-1
> > protocol then read are always correct. For 1-4-4 protocol read are
> > wrong and on further debugging found that Read code of 0x6C is being
> > send as opcode instead of 0xEC.
> > 
> > If I revert this patch, reads are working fine.  
> 
> Can you try with the following patch?
> 

Hm, nevermind. The problem is actually not related to 4B vs non-4B mode
but 1-1-4 vs 1-4-4 modes.
