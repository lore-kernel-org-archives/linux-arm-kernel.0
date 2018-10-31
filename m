From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 31 Oct 2018 14:18:19 +0000
Subject: [PATCH v4 1/3] arm64: implement ftrace with regs
In-Reply-To: <nycvar.YFH.7.76.1810311417361.30233@cbobk.fhfr.pm>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142148.6353A68C94@newverein.lst.de>
 <20181031121002.hmag2mwvlpzwobvf@lakrids.cambridge.arm.com>
 <nycvar.YFH.7.76.1810311417361.30233@cbobk.fhfr.pm>
Message-ID: <20181031141819.lv2tuj4ne5nf3lh3@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2018 at 02:19:07PM +0100, Jiri Kosina wrote:
> On Wed, 31 Oct 2018, Mark Rutland wrote:
> 
> > I guess skipping the original function prologue would simplify the
> > implementation of the replacement function (and would mean that the regs
> > held the function arguments per the procedure call standard), but AFAICT
> > other architectures aren't relying on that, so it doesn't seem to be a
> > strict requirement.
> > 
> > What am I missing?
> > 
> > How does livepatching handle the pre-mcount function preambles on
> > architectures with existing support?
> 
> Other architectures do rely on that. That's exactly for example why on x86 
> we use '-pg -mfentry', to make sure we hook the function *before* 
> prologue.

Ah, I'd missed -mfentry for x86. I now see that's also the case with
__gnu_mcount_nc on arch/arm, so that covers my confusion.

Thanks for correcting me, and sorry for noise!

Mark.
