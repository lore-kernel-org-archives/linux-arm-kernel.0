From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 19 Apr 2010 06:42:29 -0600
Subject: 32-bit transfers broken in OMAP SPI driver?
In-Reply-To: <Pine.LNX.4.64.1004190950380.4080@axis700.grange>
References: <Pine.LNX.4.64.1004190950380.4080@axis700.grange>
Message-ID: <t2yfa686aa41004190542s2e1596abs11e0762e60ef73d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cory, can you please take a look at this?

Thanks,
g.

On Mon, Apr 19, 2010 at 1:58 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Ran across drivers/spi/omap_spi_100k.c and its handling of > 16-bit
> transfers seems buggy to me. Firstly, addresses do not get incremented in
> omap1_spi100k_txrx_pio() (word_len <= 32) case, a fix for which seems to
> be obvious, secondly, spi100k_write_data() and spi100k_read_data() only
> write / read 16-bit data blocks, for which I'm not adventurous enough to
> propose a patch without even touching the hardware;) Am I right? Maybe
> just disable > 16-bit transfers altogether, since they are broken, and
> thus, obviously, unused.
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
