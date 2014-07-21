From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Jul 2014 09:48:23 +0100
Subject: [PATCH resend v2] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <CAKv+Gu9K=Hp97cFK2D_HTe=CD6-spvUcP6itOyLB-DcgQatmyA@mail.gmail.com>
References: <1405079210-30044-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140714133644.GE1779@arm.com>
 <CAKv+Gu_2CYU+Th4xZ3EfjCFqQzBfJ88Hrtx1LwUbG79+1=cqJw@mail.gmail.com>
 <CAKv+Gu9K=Hp97cFK2D_HTe=CD6-spvUcP6itOyLB-DcgQatmyA@mail.gmail.com>
Message-ID: <20140721084823.GA15666@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 20, 2014 at 11:25:34AM +0100, Ard Biesheuvel wrote:
> On 14 July 2014 15:57, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 14 July 2014 15:36, Will Deacon <will.deacon@arm.com> wrote:
> >> On Fri, Jul 11, 2014 at 12:46:50PM +0100, Ard Biesheuvel wrote:
> >>> From: Yi Li <yi.li@linaro.org>
> >>>
> >>> SMbios is important for server hardware vendors. It implements a spec for
> >>> providing descriptive information about the platform. Things like serial
> >>> numbers, physical layout of the ports, build configuration data, and the like.
> >>>
> >>> This has been tested by dmidecode and lshw tools.
> >>>
> >>> Signed-off-by: Yi Li <yi.li@linaro.org>
> >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>> ---
> >>> Changes since previous version:
> >>> - changed double inclusion guard to arm64 flavour
> >>> - use kzalloc(GFP_KERNEL) as GFP_ATOMIC is not needed
> >>> - do a sanity check on the size of the requested mapping
> >>
> >> Technically, this patch looks fine to me:
> >>
> >>   Reviewed-by: Will Deacon <will.deacon@arm.com>
> >>
> 
> Hello Catalin,
> 
> This has been tested by Yi on FVP and Juno.
> Are you ok to take this?

Out of interest, how did you test it on Juno? I tried but got some messages
about missing/invalid DMI data or something similar. Leif reckons I need
some tricked out firmware for the FVP to get something working, but even
then the information is apparently bogus.

Will
