From: icenowy@aosc.io (icenowy at aosc.io)
Date: Mon, 07 Aug 2017 21:18:26 +0800
Subject: [PATCH] pinctrl: sunxi: fix V3s pinctrl driver IRQ bank base
In-Reply-To: <CACRpkdYJX6SX5NjLMopoD7nKkmhseBMMTei-FoxzXwRnNDUaFg@mail.gmail.com>
References: <20170801145416.61854-1-icenowy@aosc.io>
 <CACRpkdYJX6SX5NjLMopoD7nKkmhseBMMTei-FoxzXwRnNDUaFg@mail.gmail.com>
Message-ID: <7ed40135b06d4389c2165cf260d0e50a@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-08-07 21:09?Linus Walleij ???
> On Tue, Aug 1, 2017 at 4:54 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> 
>> The V3s pin controller doesn't have the bank 0 (starts at address
>> 0x200), which is like A33. However, this is not workarounded when
>> developing the driver, which makes IRQ not working.
>> 
>> Fix the IRQ bank base.
>> 
>> Fixes: 56d9e4a76039 ("pinctrl: sunxi: add driver for V3s SoC")
>> Cc: stable at vger.kernel.org
> 
> This patch only applies on the devel branch so I don't see why it is 
> tagged
> for stable.

I can apply it on v4.12 tag.

The V3s pinctrl driver is introduced in 4.11.

> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> 
> Patch applied.
> 
> Yours,
> Linus Walleij
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
