From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Sat, 1 Jun 2013 17:11:48 +0530
Subject: MUSB multiplatform work?
In-Reply-To: <20130530203132.GC6467@atomide.com>
References: <201305271702.09203.arnd@arndb.de>
 <20130528163548.GC28253@arwen.pp.htv.fi>
 <20130530201854.GB6467@atomide.com>
 <CACRpkdZHupVFS+pNADpaJjunPa3fEtyCqLwbL-etHs3gt8EW0Q@mail.gmail.com>
 <20130530203132.GC6467@atomide.com>
Message-ID: <CAJe_Zhc14i77zKmnRRkFRXo+rEGfFa5kD1ag+CZSocKRztH=Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 May 2013 02:01, Tony Lindgren <tony@atomide.com> wrote:
> * Linus Walleij <linus.walleij@linaro.org> [130530 13:27]:
>> On Thu, May 30, 2013 at 10:18 PM, Tony Lindgren <tony@atomide.com> wrote:
>>
>> > TUSB would work with dmaengine, but AFAIK we're still missing the
>> > dmaengine configuration options to support increasing device end
>> > FIFO address.
>>
>> Can you elaborate on this? What is the usecase here?
>
> There are many devices where the device FIFO is memory mapped to the
> GPMC bus on omaps, like TUSB, OneNAND, smc911x etc. I believe the
> only reason why these have not been converted to the dmaengine is
> the fact that dmaengine cannot configure the DMA hardware to do
> autoincrement and loop over the device FIFO.
>
Doesn't device_prep_interleaved_dma() help?

-jassi
