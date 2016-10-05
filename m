From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 5 Oct 2016 21:44:53 +0100
Subject: [PATCH v2] arm: Added support for getcpu() vDSO using TPIDRURW
In-Reply-To: <CAKdL+dQH=9C2aGf7ys5-vXM7pkdPYUQ8xYWLipwVbABOz09f1g@mail.gmail.com>
References: <1475589000-29315-1-git-send-email-fredrik.markstrom@gmail.com>
 <1475595363-4272-1-git-send-email-fredrik.markstrom@gmail.com>
 <20161004170741.GC29008@leverpostej>
 <CAKdL+dS4_My6hyMEGNc65mzDapia_tMiVzZ9DMw=ddZM+XiwAw@mail.gmail.com>
 <CAKdL+dTGDqgpnMTkAj=N4cY-cZF_U+bkH1v1vUA4umZoSbWHKQ@mail.gmail.com>
 <50e025e0-7052-9b15-3b3e-36d1d9dfd695@arm.com>
 <CAKdL+dQH=9C2aGf7ys5-vXM7pkdPYUQ8xYWLipwVbABOz09f1g@mail.gmail.com>
Message-ID: <20161005204452.GB26721@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2016 at 08:00:38PM +0000, Fredrik Markstr?m wrote:
> On Wed, Oct 5, 2016 at 7:48 PM Robin Murphy <robin.murphy@arm.com> wrote:
> As far as I understand TPIDRURW isn't anything else then an architecture
> specific piece of tls since the last patch, possibly slightly faster then a
> "__thread u32 x;"
> 
> The irony is that the two different ways it was handled earlier (not context
> switched or always set to zero on swap in) would have made it useful for this
> purpose.

The "not context switched" case was also arbitrarily corrupted, and could not
have been relied upon.

The zeroing case is similar to the restartable sequences design. So that's
probably worth looking into.

Thanks,
Mark.
