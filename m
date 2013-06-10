From: robherring2@gmail.com (Rob Herring)
Date: Mon, 10 Jun 2013 14:53:17 -0500
Subject: [EXAMPLE PATCH] pinctrl: add pinctrl driver for Rockchip SoCs
In-Reply-To: <51B619B9.8040204@wwwdotorg.org>
References: <201306090159.05383.heiko@sntech.de>
 <201306090201.17739.heiko@sntech.de>
 <CACRpkdaEcZZ3NZzwKOhUPjvFg+bSZ=UbpyPT2EBcAfVv1-EsKA@mail.gmail.com>
 <51B619B9.8040204@wwwdotorg.org>
Message-ID: <51B62EAD.5000601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2013 01:23 PM, Stephen Warren wrote:
> On 06/10/2013 07:00 AM, Linus Walleij wrote:
>> On Sun, Jun 9, 2013 at 2:01 AM, Heiko St?bner <heiko@sntech.de> wrote:
>>
>> (...)
>>> +#include <linux/irqchip/chained_irq.h>
>>> +#include <linux/clk-provider.h>
>>> +#include <dt-bindings/pinctrl/rockchip.h>
>>
>> Hm I don't know if we're supposed to do things like this actually.
>>
>> It depends on whether the <dt-bindings/*> hierarchy is supposed
>> to stay in the kernel after the device trees are moved out to a
>> separate repo.
>>
>> Grant/Rob, shall we do this in drivers?
> 
> The entire reason I created the <dt-bindings/> directory (rather than
> just putting *.h into e.g. arch/arm/boot/dts) was to provide a place to
> share binding-defined constants between the DT files and drivers that
> implement that binding. It's certainly my opinion that if/when *.dts
> move out of the kernel, the <dt-bindings/> directory should continue to
> be present in the kernel, and take updates mirrored from the upstream
> binding repo.

Yes, agreed. Only kernel headers in a dts would be a problem.

Rob
