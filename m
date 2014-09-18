From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 18 Sep 2014 09:57:42 +0800
Subject: [PATCH 2/3] dmaengine: sun6i: Add support for Allwinner A23
 (sun8i) variant
In-Reply-To: <20140917155540.GJ2166@lukather>
References: <1410616381-30226-1-git-send-email-wens@csie.org>
 <1410616381-30226-3-git-send-email-wens@csie.org>
 <20140916103540.GF9948@lukather>
 <CAGb2v67jokpXHxR26YoCEB2Y_v07oQZXZfPuGJC_wO=r-SRZhg@mail.gmail.com>
 <20140917155540.GJ2166@lukather>
Message-ID: <CAGb2v65p4QPJY+eiLps6C2kAZjhPd99D5YYauwUjLJnnj54B1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 11:55 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Sep 16, 2014 at 10:13:27PM +0800, Chen-Yu Tsai wrote:
>> >> +     /*
>> >> +      * sun8i variant requires us to toggle an undocumented register,
>> >> +      * as seen in Allwinner's SDK.
>> >
>> > The BSP I have has this:
>> >
>> > static void sunxi_dma_hw_init(struct sunxi_dmadev *dev)
>> > {
>> >         struct sunxi_dmadev *sunxi_dev = dev;
>> >
>> >         clk_prepare_enable(sunxi_dev->ahb_clk);
>> > #ifdef CONFIG_ARCH_SUN8IW3
>> >         writel(0x04, sunxi_dev->base + DMA_GATE);
>> > #endif
>> > }
>> >
>> > /* All is ok, and open the clock */
>> > sunxi_dma_hw_init(sunxi_dev);
>> >
>> > So I guess we can say that it's not that undocumented :)
>>
>> That's right. I meant undocumented in the user manual.
>> I did reference the SDK in the comment, didn't I? :)
>
> So something like
>
> writel(DMA_GATE_ENABLE, base->DMA_GATE_REG) wouldn't be too far off :)

Sure. Will also update the comment to reflect the naming.

ChenYu
