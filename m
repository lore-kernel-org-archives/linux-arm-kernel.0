From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Jul 2012 12:31:08 +0100
Subject: linux-next: manual merge of the arm-soc tree with the i2c-embedded
 tree
In-Reply-To: <20120716101706.GB17435@pengutronix.de>
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
 <20120712131231.GH2194@pengutronix.de>
 <CACRpkdboeF_G=sTPeSyuZ6KGLCmGSKx_NS=6Rim6HkR2f9=AAQ@mail.gmail.com>
 <20120716101706.GB17435@pengutronix.de>
Message-ID: <5003FB7C.4030509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/12 11:17, Wolfram Sang wrote:
>
>> Well I think I ACKed that from the point of view that it will work as
>> expected with ux500 with these bindings. What is best from the I2C
>> subsystem point of view is another question ...
>
> Okay, thanks for clarifying.
>
>> Overall I think we have this general problem with a lot of DT
>> conversion happening right now: the tempo is set very high and
>> all chip vendors want DT support RealQuickNowPreferrablyYesterday
>> and that makes it hard for subsystem maintainers to hold back,
>> and I also fear vendor-specific properties are overused for this
>> reason.
>
> Word.
>
>> And about the perpetual nature of device tree bindings it
>> appears to me that the modus operandi right now is to not
>> regard any of these as written in stone until they are removed
>> from the kernel tree. We have plenty of drivers patching
>> trees and drivers in one for the moment.
>
> I don't get this one. Yes, they are of perpetual nature, so how could we
> remove them from the kernel tree?
>
> What I am afraid of is: tentative solutions tend to stay, because the
> need for a proper solution is reduced. Yet, finding proper generic
> bindings might take some time which doesn't meet the high pressure
> around DT at the moment.

I agree with what you say to some extent, but I believe that it is more 
important to have a working solution now than to ensure that each 
bindings are as unique as possible. After any suggestion of 
consolidation, a move from vendor specific to generically defined Device 
Tree bindings is trivial. Especially in the current stage where 
adaptions and definitions are still fluid.

Obviously some care is taken to ensure the bindings are as generic as 
possible, but not to the extent that will put the project back some 
months. Over past few months I have enabled many sub-systems; however, I 
think it would have been a fraction of that if we'd gone through the 
laborious process of immediate forced consolidation. I think it's fine 
to have platform/vendor specific bindings that work, then come back to 
unify them once the dust settles.

If you know of any bindings which you know are generic, I'm happy to 
define and swap them out for the ones I've proposed, but due to a change 
of project focus I can't afford to spend hours studying all of the 
drivers to match-up possible unifications.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
