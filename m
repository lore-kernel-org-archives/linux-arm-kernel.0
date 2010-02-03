From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 3 Feb 2010 10:48:23 -0700
Subject: [spi-devel-general] PATCH [1/1] SPI: AMBA_PL022: Limit TX FIFO
	fills based on current RX FIFO used
In-Reply-To: <63386a3d1001220456p484efc7fm811ae2240698cbdf@mail.gmail.com>
References: <083DF309106F364B939360100EC290F805C4BF1E97@eu1rdcrdc1wx030.exi.nxp.com>
	<63386a3d1001220456p484efc7fm811ae2240698cbdf@mail.gmail.com>
Message-ID: <fa686aa41002030948g6359ef3o4c3a7b265490b93f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2010 at 5:56 AM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/1/20 Kevin Wells <kevin.wells@nxp.com>:
>
>> Added logic to cap TX FIFO fill size based on current free RX
>> FIFO entries instead of TX status flags. This is to prevent
>> an issue with RX FIFO overflows
>
> Excellent patch and works like a charm on the U300. My loopback code
> would generate
> spurious overfill errors before and now it *never* fails so you hit
> exactly the right spot.
> I remember being intrigued by this when I worked on the driver and now
> it is finally
> nailed.
>
> As some sort of maintainer of this file I have signed it off and put
> it into Russells
> patch tracker for inclusion, OK? See;
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5893/1

I'm actively maintaining SPI now.  In general, I'd prefer SPI patches
to go through the SPI tree, unless there are commit ordering issues
with arch code.  I'm tracking SPI patches with patchwork:

http://patchwork.kernel.org/project/spi-devel-general/list/

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
