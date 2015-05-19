From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 19 May 2015 13:58:03 +0100
Subject: [PATCH v2 3/5] arm64: Juno: Add memory mapped timer node
In-Reply-To: <20150519113116.GH2175@e106497-lin.cambridge.arm.com>
References: <1431970109-8902-1-git-send-email-Liviu.Dudau@arm.com>
 <1431970109-8902-4-git-send-email-Liviu.Dudau@arm.com>
 <1432033003.3047.43.camel@linaro.org>
 <20150519113116.GH2175@e106497-lin.cambridge.arm.com>
Message-ID: <1432040283.3047.54.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-19 at 12:31 +0100, Liviu Dudau wrote:
> On Tue, May 19, 2015 at 11:56:43AM +0100, Jon Medhurst (Tixy) wrote:
> > On Mon, 2015-05-18 at 18:28 +0100, Liviu Dudau wrote:
> > > Juno based boards have a memory mapped timer @ 0x2a810000. This
> > > is disabled on r0 version of the board due to an SoC errata.
> > 
> > So wouldn't it make more sense then to disable it in the dts for r0? As
> > it is, you disable it in the common file below then have to later
> > re-enable it in juno-r1.dts.
> 
> From what I have seen in the existing DTs the preffer approach seems to be of
> disabling by default the node declared in the common files and enable
> it in the DT that makes use of it.

Yes, I does look that way, and I agree consistency usually wins out over
any arguments over log or obviousness.

> If there is any guidance on how to describe this sort of situations I
> would really love to read it.

I know of none, but I'd speculate the principal we've discovered is to
fail safe and have potentially absent or broken hardware disabled by
default.

-- 
Tixy
