From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Nov 2015 11:54:00 +0000
Subject: [V3 PATCH] arm64: remove redundant FRAME_POINTER kconfig option
 and force to select it
In-Reply-To: <D0F23548-7A9E-4D3A-8FBD-1D8DA6FFAA26@gmail.com>
References: <1447092595-12644-1-git-send-email-yang.shi@linaro.org>
 <20151110103752.GH21606@e104818-lin.cambridge.arm.com>
 <49B0431C-4FDA-45CB-82AF-FA010197118D@gmail.com>
 <20151110113505.GI21606@e104818-lin.cambridge.arm.com>
 <D0F23548-7A9E-4D3A-8FBD-1D8DA6FFAA26@gmail.com>
Message-ID: <20151110115359.GE31947@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 07:43:35PM +0800, yalin wang wrote:
> > On Nov 10, 2015, at 19:35, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Nov 10, 2015 at 07:09:00PM +0800, yalin wang wrote:
> >> i have a question,
> >> why FRAME_POINTER  config must be enabled ?
> >> and i see ARM arch can  disable this config .
> >> if i don?t need stack trace dump and the software release is for 
> >> final product , don?t need debug stack trace log .
> >> is it possible to disable it for performance reason ?
> > 
> > If you don't need any stack trace, perf etc., in theory you can disable
> > the option. However, the aarch64 gcc compiler always generates it (I'm
> > not sure whether the AAPCS mandates it). Anyway, the performance impact
> > is very small since there are more general purpose registers available
> > in AArch64 already.
> > 
> i just make a test with -fomit-frame-pointer,  seems gcc can generate code
> without frame pointer,

Building without frame-pointers *severely* limits our ability (as
open-source developers) to debug problems that we are unable to reproduce
locally. Given the lack of widely available hardware compared to the
number of platforms in development, I'm strongly opposed to offering this
as a supported option for mainline kernels without a compelling performance
argument.

We have a significant number of general-purpose registers available on
arm64, so I would expect the omission of a framepointer to have a
somewhat limited impact on performance.

Will
