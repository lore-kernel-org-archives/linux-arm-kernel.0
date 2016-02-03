From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 3 Feb 2016 12:17:24 +0100
Subject: [PATCH] dmaengine: use phys_addr_t for slave configuration
In-Reply-To: <20151215172649.GK1854@localhost>
References: <1366967214-20776-1-git-send-email-linus.walleij@linaro.org>
 <CAMuHMdUTzTBT8DyRb5WN048U5DbVsFnhJB0c5tjHBnA4rfetJg@mail.gmail.com>
 <20150710081411.GF836@localhost>
 <CAMuHMdV8a1W1MyJPanUNBzaiNsL96JYzetBVSiZoC3=eKXzo1Q@mail.gmail.com>
 <20151215172649.GK1854@localhost>
Message-ID: <CAMuHMdXe8i2JbhOP2sWkVkqHEeBnW4AfVBbRaoZW=Kg0s_9m3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Tue, Dec 15, 2015 at 6:26 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Dec 15, 2015 at 11:48:24AM +0100, Geert Uytterhoeven wrote:
>> On Fri, Jul 10, 2015 at 10:14 AM, Vinod Koul <vinod.koul@intel.com> wrote:
>> > On Wed, Jul 08, 2015 at 12:12:52PM +0200, Geert Uytterhoeven wrote:
>> >> On Fri, Apr 26, 2013 at 11:06 AM, Linus Walleij

(yes, 2013)

>> >> <linus.walleij@linaro.org> wrote:
>> >> > The documentation already says these are physical addresses, and
>> >> > we have concluded that any translation into the DMA address space
>> >> > needs to reside in the dmaengine driver, so change the type of
>> >> > the passed arguments.
>> >> >
>> >> > Cc: Arnd Bergmann <arnd@arndb.de>
>> >> > Cc: Lee Jones <lee.jones@linaro.org>
>> >> > Cc: Vinod Koul <vinod.koul@intel.com>
>> >> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> >>
>> >> What's the status of this one, which has been acked by Lee and Arnd?
>> > Looks to have slipped thru. I will redo it
>>
>> Ping?
>
> I should be able to do this in next few days...

Ping?

This is a dependency for adding iommu support to the rcar-dmac driver, cfr.
"[PATCH v2 0/5] dmaengine: rcar-dmac: add iommu support for slave transfers".
http://www.spinics.net/lists/linux-renesas-soc/msg00066.html
https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg00108.html

Thank you for applying!

>> >> > ---
>> >> >  include/linux/dmaengine.h | 4 ++--
>> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >> >
>> >> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> >> > index 91ac8da..681df5f9 100644
>> >> > --- a/include/linux/dmaengine.h
>> >> > +++ b/include/linux/dmaengine.h
>> >> > @@ -361,8 +361,8 @@ enum dma_slave_buswidth {
>> >> >   */
>> >> >  struct dma_slave_config {
>> >> >         enum dma_transfer_direction direction;
>> >> > -       dma_addr_t src_addr;
>> >> > -       dma_addr_t dst_addr;
>> >> > +       phys_addr_t src_addr;
>> >> > +       phys_addr_t dst_addr;
>> >> >         enum dma_slave_buswidth src_addr_width;
>> >> >         enum dma_slave_buswidth dst_addr_width;
>> >> >         u32 src_maxburst;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
