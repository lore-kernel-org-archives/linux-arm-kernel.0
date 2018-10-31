From: duwe@lst.de (Torsten Duwe)
Date: Wed, 31 Oct 2018 18:58:00 +0100
Subject: [PATCH v4 1/3] arm64: implement ftrace with regs
In-Reply-To: <20181031141819.lv2tuj4ne5nf3lh3@lakrids.cambridge.arm.com>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142148.6353A68C94@newverein.lst.de>
 <20181031121002.hmag2mwvlpzwobvf@lakrids.cambridge.arm.com>
 <nycvar.YFH.7.76.1810311417361.30233@cbobk.fhfr.pm>
 <20181031141819.lv2tuj4ne5nf3lh3@lakrids.cambridge.arm.com>
Message-ID: <20181031185800.6aa17c91@blackhole>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Oct 2018 14:18:19 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Oct 31, 2018 at 02:19:07PM +0100, Jiri Kosina wrote:

> > Other architectures do rely on that. That's exactly for example why
> > on x86 we use '-pg -mfentry', to make sure we hook the function
> > *before* prologue.  
> 
> Ah, I'd missed -mfentry for x86. I now see that's also the case with
> __gnu_mcount_nc on arch/arm, so that covers my confusion.

Yes, fentry used to be the prerequisite, but it's everything but
portable. PPC64 already had the profile-kernel switch, which was
becoming just usable as we got at live patching.

I'm hoping that the patchable-function-entry will become the future
de-facto standard.

	Torsten
