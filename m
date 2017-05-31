From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 31 May 2017 12:33:05 +0100
Subject: [RFC PATCH v3 0/4] Simplify kernel-mode NEON
In-Reply-To: <CAKv+Gu_V41O67etpYErj_xX1JG+RcSxkq25WpFwTvyBNDETa8w@mail.gmail.com>
References: <1495736721-20985-1-git-send-email-Dave.Martin@arm.com>
 <20170530180219.GR3559@e103592.cambridge.arm.com>
 <CAKv+Gu-FxRLKxTvC68Wu0_o1zjSfjWDtdA7hdK79ZTNWNXPj=Q@mail.gmail.com>
 <20170531100758.GA30160@e103592.cambridge.arm.com>
 <CAKv+Gu_V41O67etpYErj_xX1JG+RcSxkq25WpFwTvyBNDETa8w@mail.gmail.com>
Message-ID: <20170531113305.GB30160@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 11:07:56AM +0000, Ard Biesheuvel wrote:
> On 31 May 2017 at 10:08, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Wed, May 31, 2017 at 08:41:01AM +0000, Ard Biesheuvel wrote:

[...]

> > Something like [1] below?  Either way, it probably makes sense for that
> > stub function to be added by your series.
> >
> 
> Pretty much, yeah. But don't forget to remove simd.h from
> arch/arm64/include/asm/Kbuild

Oh wow, I thought that was done by magic.

> >> BTW I got my ZD1211 working on my MacchiatioBin board. The performance
> >> is terrible, but that should not matter: if I can saturate a CPU doing
> >
> > Do you mean that my series causes a performance regression here, or is
> > the performance terrible anyway?
> >
> 
> No, the performance is terrible, which shouldn't matter per se, but it
> would be nice if the load induced by the mac80211 were visible in
> 'top' as wait, sys or whatever-it-is-called time. Currently, the 3
> Mbit/s throughput combined with the 2.2 cycles per byte performance of
> the AES-CCM code makes the code unnoticeable.
> 
> >> NEON from userland and/or kernel process context, the softirq
> >> interruptions by the mac80211 code should exercise the updated code
> >> paths. I haven't tried that yet: let me get the code changes out
> >> today, so you can put your stuff on top. Then we can give it a good
> >> spin.
> >
> > That would be great, thanks.
> >
> 
> I have updated my branch here:
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=kernel-mode-neon

Looks good.

> I removed all kernel_neon_begin_partial() invocations as well.

OK, I will drop that from my series.

Cheers
---Dave
