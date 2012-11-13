From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Nov 2012 22:53:07 +0000
Subject: [PATCH V2 4/5] arm: mm: Added support for PJ4B cpu and init
 routines
In-Reply-To: <50A26404.9010202@free-electrons.com>
References: <1351545108-18954-1-git-send-email-gregory.clement@free-electrons.com>
 <1351545108-18954-5-git-send-email-gregory.clement@free-electrons.com>
 <50A26404.9010202@free-electrons.com>
Message-ID: <20121113225307.GA9094@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 03:15:16PM +0000, Gregory CLEMENT wrote:
> >  __v7_setup:
> >  	adr	r12, __v7_setup_stack		@ the local stack
> >  	stmia	r12, {r0-r5, r7, r9, r11, lr}
> > @@ -342,6 +375,16 @@ __v7_ca9mp_proc_info:
> >  	.long	0xff0ffff0
> >  	__v7_proc __v7_ca9mp_setup
> >  	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
> > +
> > +	/*
> > +	 * Marvell PJ4B processor.
> > +	 */
> > +	.type   __v7_pj4b_proc_info, #object
> > +__v7_pj4b_proc_info:
> > +	.long	0x562f5842
> > +	.long	0xffffffff

This mask seems a little excessive -- does your cpuid not contain revision
information? If so, I'm not sure we want to update the code every time there
is a new spin of the same CPU.

Will
