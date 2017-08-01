From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Aug 2017 12:31:21 +0100
Subject: [PATCH] arm64: acpi/gtdt: validate CNTFRQ after having enabled
 the frame
In-Reply-To: <CAKv+Gu8jD_oJV138qWGQm2dOnqJTSxSNNQ7xFCPtb4efyR9n1Q@mail.gmail.com>
References: <20170724151053.17769-1-ard.biesheuvel@linaro.org>
 <20170801105345.GB9347@leverpostej>
 <CAKv+Gu8jD_oJV138qWGQm2dOnqJTSxSNNQ7xFCPtb4efyR9n1Q@mail.gmail.com>
Message-ID: <20170801113120.GD9347@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 12:09:32PM +0100, Ard Biesheuvel wrote:
> On 1 August 2017 at 11:53, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Jul 24, 2017 at 04:10:53PM +0100, Ard Biesheuvel wrote:
> >> So move the validation of CNTFRQ into the loop that iterates over the
> >> timers to find the best frame, and only validate the frame that has
> >> been selected as the best frame (and has thus been enabled).
> >
> > The intention here was to verify all frames, such that if/when we choose
> > to use other frames in future, CNTFRQ will be valid. This is stricter
> > than the DT case, which I'd also make stricter were it not for legacy.
> >
> > So while that check needs to be corrected, I'd like to retain the check
> > for all frames.
> 
> The point here is that CNTFRQ cannot differ between frames. It either
> returns the value of the base frame or RES0.

Sorry; you had mentioned this before, and I had forgotten.

I'm under the impression that the ARM ARM may be misleading (and
potentially erroneous) in that regard. In the past I had been told that
each instance of a CNTFRQ register was independent, and each must be
writeable for system initialization.

I will try to get that clarified ASAP.

Thanks,
Mark.
