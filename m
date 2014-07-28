From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Jul 2014 19:46:04 +0100
Subject: EL3 firmware init of cores ( was Re: [PATCH] arm64: Flush the
 process's mm context TLB entries when switching)
In-Reply-To: <CALRxmdCxnOmZdY=_CCYRT8YYBkVdS-ch6RRbkfZa2B-sF_FkKg@mail.gmail.com>
References: <CALRxmdCxnOmZdY=_CCYRT8YYBkVdS-ch6RRbkfZa2B-sF_FkKg@mail.gmail.com>
Message-ID: <20140728184604.GS15536@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stuart,

On Mon, Jul 28, 2014 at 07:40:27PM +0100, Stuart Yoder wrote:
> On Tue, Apr 15, 2014 at 3:02 AM, Will Deacon <will.deacon@arm.com> wrote:
> > No, there's usually a CPU-specific register (called something like actlr or
> > ectlr) which contains bit(s) to enable TLB broadcasting in hardware. Which
> > CPU are you using?
> 
> We ran into this same issue as well for an A57-based system.  We are using
> u-boot and it seems that some early EL3 init was missing the setting of the
> SMPEN bit.
> 
> I'm concerned now that there may be other bits we have missed as well.  Is
> there any documentation you know of that details A57 initialization or do we
> just have to extract that from the reference manual?
> 
> Also, for ARM development systems like the Versatile Express or fast model
> is there existing "EL3 firmware" source available that shows how to properly
> initialize an A57 that we can refer to?    Any pointer to reference code doing
> this initialization would be really appreciated.

Sure, take a look at the ARM trusted firmware:

  https://github.com/ARM-software/arm-trusted-firmware

That's actually the firmware that runs on Juno at EL3 and provides a bunch
of stuff as well as initialising the platform (PSCI etc). For example, the
SMP bit is set in lib/aarch64/cpu_helpers.S

Will
