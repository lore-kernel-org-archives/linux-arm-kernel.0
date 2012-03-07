From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 7 Mar 2012 10:49:46 +0800
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120127155454.GH2347@mudshark.cambridge.arm.com>
References: <CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
 <CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
 <CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
 <CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
 <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
 <20120127121311.GB2347@mudshark.cambridge.arm.com>
 <yw1x1uqlnw1o.fsf@unicorn.mansr.com>
 <20120127132826.GD2347@mudshark.cambridge.arm.com>
 <CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
 <CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
 <20120127155454.GH2347@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVNExXcU473=m5QLZXAhpNsC3WZHrFa-=HzGdjMEy3seDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Jan 27, 2012 at 11:54 PM, Will Deacon <will.deacon@arm.com> wrote:
> Ok. Note that on ARM the PMU generates a standard IRQ (i.e. not an NMI) so
> you may miss samples if they occur during critical kernel sections (and if
> you look at a profile, spin_unlock_irqrestore will be quite high).

Also looks no any irq handler functions can be observed at a profile even
though they may be run at a very high frequency.

So could we configure ARM PMU interrupt as FIQ to address the above issues?

thanks
--
Ming Lei
