From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 3 Dec 2016 19:03:47 +0200
Subject: [GIT PULL 1/3] ARM: exynos: Soc/mach for v4.10
In-Reply-To: <57568492.9hbg5JCdec@wuerfel>
References: <1479967709-6619-1-git-send-email-krzk@kernel.org>
 <1479967709-6619-2-git-send-email-krzk@kernel.org>
 <20161201183404.GA2134@kozik-lap> <57568492.9hbg5JCdec@wuerfel>
Message-ID: <20161203170347.GA3553@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 10:52:57PM +0100, Arnd Bergmann wrote:
> On Thursday, December 1, 2016 8:34:04 PM CET Krzysztof Kozlowski wrote:
> > On Thu, Nov 24, 2016 at 08:08:27AM +0200, Krzysztof Kozlowski wrote:
> > > Hi,
> > > 
> > > This contains previous dts branch because SCU node in dts is needed
> > > prior to removing it from mach code.
> > > 
> > > Below you will find full pull request and one stripped from dependency.
> > > 
> > 
> > Hi Arnd, Kevin and Olof,
> > 
> > What about this pull from the set?
> > 
> 
> Sorry, I initially deferred it and then didn't get back to it.
> 
> The dependency on the .dts changes made me a bit nervous about
> taking it, mostly because the changelog fails to explain the
> exact dependencies.
> 
> This breaks compatibility with existing .dtb files, right?

No, strictly speaking not. There was no dt-bindings change here, no DT
properties for SCU before. We are converting our drivers to DTB so this
is the same as before when switching for pinctrl, clocks or all other
drivers to DT.

We are not braking DTB ABI because there was no ABI around it before.
Otherwise, one would say that lack of SCU DT node was an ABI. That is
wrong, because DT should describe the hardware and SCU is in hardware.

> What I'd like to see here is an explanation about:
> 
> - what the upside of breaking compatibility is

DTBs which do not have SCU are not proper because they skip that part of
hardware. However we are breaking them in the way the SMP won't work
there. It is not an ABI break, as I mentioned above.

> - what exactly stops working with an old dtb
> - why we don't keep a fallback for handling old dtb files

What is the point for it? This is not an ABI break. Even if it was,
Samsung guys don't care for ABI breaks at all (and in fact we wanted to
mark the platform experimental...).

> It would also be helpful to have a separate pull request for
> the commits require the new dtb, and the stuff that is unrelated.

I can do that but the pull will be small.

Best regards,
Krzysztof
