From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 19 Oct 2018 16:54:10 +0100
Subject: [PATCH v5 07/17] arm64: add basic pointer authentication support
In-Reply-To: <CAGXu5j+2axuzPJji_eCvMZDiPvrPsP3kAnG0CY_rsL5c=uFQFA@mail.gmail.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-8-kristina.martsenko@arm.com>
 <20181019111542.6wrvjguirglzg7vg@mbp>
 <20181019112404.GD14246@arm.com>
 <CAGXu5j+2axuzPJji_eCvMZDiPvrPsP3kAnG0CY_rsL5c=uFQFA@mail.gmail.com>
Message-ID: <20181019155410.wsbmhluq4xqcyty2@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 08:36:45AM -0700, Kees Cook wrote:
> On Fri, Oct 19, 2018 at 4:24 AM, Will Deacon <will.deacon@arm.com> wrote:
> > Assuming we want this (Kees -- I was under the impression that everything in
> > Android would end up with the same key otherwise?), then the question is
> > do we want:
> >
> >   - prctl() get/set operations for the key, or
> >   - prctl() set_random_key operation, or
> >   - both of the above?
> >
> > Part of the answer to that may lie in the requirements of CRIU, where I
> > strongly suspect they need explicit get/set operations, although these
> > could be gated on CONFIG_CHECKPOINT_RESTORE=y.
> 
> Oh CRIU. Yikes. I'd like the get/set to be gated by the CONFIG, yes.
> No reason to allow explicit access to the key (and selected algo) if
> we don't have to.

As a minor aside, the PAC algorithm (which can be IMPLEMENTATION
DEFINED) is fixed in HW, and cannot be selected dynamically.

Thus if a process is using pointer authentication, it would not be
possible for CRIU to migrate that process to a CPU with a different PAC
algorithm.

Thanks,
Mark.
