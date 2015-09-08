From: marex@denx.de (Marek Vasut)
Date: Tue, 8 Sep 2015 18:29:10 +0200
Subject: [PATCH linux-next v5 1/5] mtd: spi-nor: notify (Q)SPI controller
 about protocol change
In-Reply-To: <55EF0AB5.3070508@atmel.com>
References: <cover.1440580764.git.cyrille.pitchen@atmel.com>
 <CAOiHx=m0FhuH5BR-EYp4yQyB83yGRzdCFAPVfqB0b0+BvRE-6Q@mail.gmail.com>
 <55EF0AB5.3070508@atmel.com>
Message-ID: <201509081829.10398.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 08, 2015 at 06:20:05 PM, Cyrille Pitchen wrote:
> Hi Jonas,
> 
> taking your comments into account I'm about to test a new series with
> additional patches to handle the Read ID command in multiple I/O protocols
> and relying on new members in the struct spi_nor:
> 
>  * @erase_proto:	the SPI protocol used by erase operations
>  * @read_proto:		the SPI protocol used by read operations
>  * @write_proto:	the SPI protocol used by write operations
>  * @reg_proto		the SPI protocol used by read_reg/write_reg operations
> 
> 	enum spi_protocol	erase_proto;
> 	enum spi_protocol	read_proto;
> 	enum spi_protocol	write_proto;
> 	enum spi_protocol	reg_proto;
> 
> This way, the read(), write(), erase(), read_reg() and write_reg() hooks
> can check the relevant protocol member so the spi-nor framework doesn't
> need to call spi_nor_set_protocol() before any command.
> 
> Also the op codes for read, page program and erase commands will be tuned
> depending on the memory manufacturer and the selected SPI protocol.
> 
> I'm likely to publish this new series tomorrow after my tests on a Micron
> memory.

Excellent, please keep me on Cc as I'm already warming up my Spansion part ;-)

Best regards,
Marek Vasut
