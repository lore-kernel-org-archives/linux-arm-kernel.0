From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 24 Apr 2013 18:50:01 +0800
Subject: [PATCH v2] arm64: compiling issue, need add include/asm/vga.h file
In-Reply-To: <20130424102327.GF21850@mudshark.cambridge.arm.com>
References: <5177551D.8090007@asianux.com> <20130424082237.GA23397@arm.com>
 <5177B1F0.10106@asianux.com>
 <20130424102327.GF21850@mudshark.cambridge.arm.com>
Message-ID: <5177B8D9.3030607@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?04?24? 18:23, Will Deacon wrote:
> On Wed, Apr 24, 2013 at 11:20:32AM +0100, Chen Gang wrote:
>> > 
>> > For compiling with allmodconfig, need vga.h file, so generate it which
>> > just only include the asm-generic one.
>> > 
>> > It is firstly used by drivers/gpu/drm/drm_irq.c.
>> > 
>> > The related error:
>> > include/video/vga.h:22:21: fatal error: asm/vga.h: No such file or directory
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> > ---
>> >  arch/arm64/include/asm/vga.h |   21 +++++++++++++++++++++
>> >  1 files changed, 21 insertions(+), 0 deletions(-)
>> >  create mode 100644 arch/arm64/include/asm/vga.h
>> > 
>> > diff --git a/arch/arm64/include/asm/vga.h b/arch/arm64/include/asm/vga.h
>> > new file mode 100644
>> > index 0000000..1c49d51
>> > --- /dev/null
>> > +++ b/arch/arm64/include/asm/vga.h
>> > @@ -0,0 +1,21 @@
>> > +/*
>> > + * Copyright (C) 2012 ARM Ltd.
>> > + *
>> > + * This program is free software; you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License version 2 as
>> > + * published by the Free Software Foundation.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + *
>> > + * You should have received a copy of the GNU General Public License
>> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> > + */
>> > +#ifndef ASMARM_VGA_H
>> > +#define ASMARM_VGA_H
>> > +
>> > +#include <asm-generic/vga.h>
>> > +
>> > +#endif /* ASMARM_VGA_H */
> Can't you just add this as a generic-y entry in asm/Kbuild?

OK, thanks, I need send patch v3.

-- 
Chen Gang

Asianux Corporation
