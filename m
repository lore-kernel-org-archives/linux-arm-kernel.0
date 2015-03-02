From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Mar 2015 14:45:03 +0000
Subject: [PATCH] arm64: Documentation: clarify Image placement in
 physical RAM
In-Reply-To: <CAKv+Gu9SvJ4nCCtCbre-hN1WFXazXCgkX15mYNsj0ZweJAD6Qw@mail.gmail.com>
References: <1425296935-19097-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150302142007.GD16779@leverpostej>
 <CAKv+Gu9SvJ4nCCtCbre-hN1WFXazXCgkX15mYNsj0ZweJAD6Qw@mail.gmail.com>
Message-ID: <20150302144502.GF16779@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 02:27:35PM +0000, Ard Biesheuvel wrote:
> On 2 March 2015 at 14:20, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Mar 02, 2015 at 11:48:55AM +0000, Ard Biesheuvel wrote:
> >> The early init code maps the kernel image using statically
> >> allocated page tables. This means that we can only allow
> >> Image to be placed such that we can map its entire static
> >> footprint using a single table entry at all but the lowest
> >> level. So update the documentation to reflect that the Image
> >> should not cross a 512 MB boundary, which ensures the above
> >> on both 4k and 64k pages kernels.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> >
> 
> Thanks.
> Note that the text is still wrong wrt to the FDT:
> 
> """
> The device tree blob (dtb) must be placed on an 8-byte boundary within
> the first 512 megabytes from the start of the kernel image [...]
> """
> 
> but perhaps we should discuss first if we want to relax the
> requirement that it shares the same 512 MB aligned region with the
> kernel.
> (RFC patch sent out last Friday, but there are some caveats)

I think we do; I've commented in that thread.

Assuming everyone else is happy with that, I guess these two patches
should be kept as a series.

Thanks,
Mark.
