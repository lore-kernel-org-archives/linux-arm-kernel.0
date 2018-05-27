From: peda@axentia.se (Peter Rosin)
Date: Sun, 27 May 2018 11:18:49 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon> <20180402222020.1d344c14@bbrezillon>
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
 <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
Message-ID: <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-25 16:51, Tudor Ambarus wrote:
> We think the best way is to keep LCD on DDR Ports 2 and 3 (8th and 9th
> slaves), to have maximum bandwidth and to use DMA on DDR port 1 for NAND
> (7th slave).

Exactly how do I accomplish that?

I can see how I can move the LCD between slave DDR port 2 and 3 by
selecting LCDC DMA master 8 or 9 (but according to the above it should
not matter). The big question is how I control what slave the NAND flash
is going to use? I find nothing in the datasheet, and the code is also
non-transparent enough for me to figure it out by myself without
throwing out this question first...

Cheers,
Peter
