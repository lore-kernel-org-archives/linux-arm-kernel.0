From: hramrach@gmail.com (Michal Suchanek)
Date: Thu, 10 Mar 2016 10:01:04 +0100
Subject: [PATCH 1/2] spi: sun4i: add DMA support
In-Reply-To: <20160306214206.GW8418@lukather>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
 <20160306214206.GW8418@lukather>
Message-ID: <CAOMqctQ5aq0A95ErVVF13f_8JBy0xRw9_FZ3avbYmZUGXp=Svg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 6 March 2016 at 22:42, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Feb 26, 2016 at 01:51:51PM +0100, Michal Suchanek wrote:

>> Besides this non-technical objection there were multiple technical
>> objections.
>>
>> IIRC one was that the driver does not handle the case when the DMA
>> channels are not available. As I understand it the channels are
>> exclusively reserved for a particular peripherial on sunxi platform so
>> this ShoulNotHappen(tm). So it's probably fine for the driver to fail
>> probe  when you have broken DT or no DMA engine support for sunxi
>> platform.
>
> There's a quite trivial scenario that would trigger this: if the dma
> driver or dmaengine is not enabled / loaded.

There are other trivial scenarios under which the driver will fail
like loading wrong DT, not compiling or loading the sunxi pinmux
driver, and whatnot.

When you misconfigure your kernel it does not work. So long as the
driver just fails and does not crash and burn it's normal. Since the
driver is pretty much useless without DMA as it is now (63 byte
transfer limit) losing the non-DMA functionality when DMA engine is
not compiled-in does not seem that terrible.

Thanks

Michal
