From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 11 Sep 2015 15:35:36 +0100
Subject: [PATCH v2] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <1441978255.18796.12.camel@redhat.com>
References: <1441906822-9222-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1441978255.18796.12.camel@redhat.com>
Message-ID: <20150911143536.GB13033@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 02:30:55PM +0100, Mark Salter wrote:
> On Thu, 2015-09-10 at 18:40 +0100, Lorenzo Pieralisi wrote:

[...]

> > +++ b/arch/arm64/kernel/acpi_parking_protocol.c
> > @@ -0,0 +1,153 @@
> > +/*
> > + * ARM64 ACPI Parking Protocol implementation
> > + *
> > + * Authors: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > + *       Mark Salter <msalter@redhat.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +#include <linux/acpi.h>
> > +#include <linux/types.h>
> > +
> > +#include <asm/cpu_ops.h>
> > +
> > +struct cpu_mailbox_entry {
> > +     phys_addr_t mailbox_addr;
> > +     u8 version;
> > +     u8 gic_cpu_id;
>         ^^^
> Shouldn't that be u32?

If I read the ACPI specs and the parking protocol specs correctly answer
is no, allowed values are 0 to 7. The ACPI MADT GICC is rather unclear on
that, I think the definition of the "CPU Interface Number" field in the
GICC structure corresponds to the Processor ID definition in the parking
protocol document attached, but I will countercheck on that and ask for
clarification.

I can certainly update both version and gic CPU id to u32, but the
question on GICC specification for the CPU Interface number is still
valid.

Thanks,
Lorenzo
