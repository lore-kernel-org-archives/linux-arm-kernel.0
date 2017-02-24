From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Feb 2017 12:16:27 +0000
Subject: [RFC PATCH 00/13] arm64/kvm: use common sysreg definitions
In-Reply-To: <20170224101650.GE1409@cbox>
References: <1485885951-2747-1-git-send-email-mark.rutland@arm.com>
 <20170224101650.GE1409@cbox>
Message-ID: <20170224121626.GC417@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2017 at 11:16:50AM +0100, Christoffer Dall wrote:
> Hi Mark,
> 
> On Tue, Jan 31, 2017 at 06:05:38PM +0000, Mark Rutland wrote:
> > Whenever we add new functionality involving new system registers, we need to
> > add sys_reg() definitions so that we can access the registers regardless of
> > whether the toolchain can assemble them. At the same time, we have to add
> > duplicate definitions of the register encodings to KVM's sysreg tables, so that
> > we can handle any configurable traps. This redundancy is unfortunate, and
> > defining the encodings directly in the sysreg tables can make those tables
> > difficult to read.
> > 
> > This series attempts to address both of these issues by allowing us to use
> > common sys_reg() mnemonics in <asm/sysreg.h> to initialise KVM's sysreg tables.
> > To that end, this series tries to make <asm/sysreg.h> the canonical location
> > for common sysreg encodings.

> I did not do a full in-depth review, but I really like this overall
> change and the changes to KVM look great to me.

Cool; I'll respin+repost this once rc1's out.

I'll have to prepare a prize for whoever's willing to verify the
encodings. ;)

Thanks,
Mark.
