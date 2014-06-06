From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 6 Jun 2014 17:34:21 -0400 (EDT)
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <20140606210126.GA10219@quad.lixom.net>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <CAD=FV=Vo1JR6n496Q3FqXjRBkbTBRg89_fJQNsqeRx8WQW_a9w@mail.gmail.com>
 <CAM4voakAMN4jdAZDPz55tnc3woZDieZ5aL3TVU2kYsNHT+AMqg@mail.gmail.com>
 <CAD=FV=UjmN5AwWMPy7mQt-J4A_niO8Ug4r15Ez2ZWPT1g3L=VA@mail.gmail.com>
 <20140606203721.GA10422@quad.lixom.net>
 <CAM4voanSpTd=dAXLZhdZKRP4Z_YShbD4Hr-6UWn3DFYueoxeTA@mail.gmail.com>
 <20140606210126.GA10219@quad.lixom.net>
Message-ID: <alpine.LFD.2.11.1406061717520.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Jun 2014, Olof Johansson wrote:

> On Sat, Jun 07, 2014 at 02:16:27AM +0530, Abhilash Kesavan wrote:
> > My answer is not "use mainline u-boot" primarily because I am not sure
> > mainline u-boot actually works on 5420 :).
> 
> And I'm saying that's not the answer primarily because we should never require
> people to update their firmware to get a usable linux system.
> 
> > My answer is keep a patch
> > locally (or make a trivial change to the bootcmd) for people who would
> > like to use an upstream kernel with the firmware on the device. Once
> > we do have a working mainline u-boot, that can then be used by the
> > interested parties.
> 
> And I am strongly NAK:ing both of those approaches. We should not require
> a single out-of-tree patch because that means we have failed to make a useful
> kernel for people. And it should never, ever, be a requirement for people to
> reflash and risk bricking their device just to run mainline linux on it.

What we can do, though, is to publicly shame you all Google People very 
strongly for not making firmware updates in the field safer and easier.  
After all you must all know already that, by definition, software always 
contains bugs.  The first feature to be tested with a new 
bootloader/firmware must be the ability to successfully and safely (and 
securely) update itself.  Especially for a mainstream device like a 
Chromebook.

> It's an artificial barrier of entry with high risk, and we'll be worse 
> off for adding it. Same for out-of-tree patches.

So ... let's find the lesser of all evils ... as always.

> iRAM is covered on Doug's sub-thread, and I think his approach looks promising.
> So, it seems like we have a solution both to enable the CCI port and to avoid
> clearing iram -- we should be set?

Care to resume the proposed solution then?


Nicolas
