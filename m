From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 08 Nov 2011 16:11:17 +0000
Subject: [RFC 6/6] ARM: vexpress: DT-based support for Coretile Express
 A5x2 (V2P-CA5s)
In-Reply-To: <4EB93E02.9000100@gmail.com>
References: <1320758169-22668-1-git-send-email-pawel.moll@arm.com>
 <1320758169-22668-7-git-send-email-pawel.moll@arm.com>
 <4EB93E02.9000100@gmail.com>
Message-ID: <1320768677.3259.115.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-11-08 at 14:34 +0000, Rob Herring wrote:
> I really think v2p-ca5s.c and v2p-ca9.c should be combined into 1 file.
> There's a lot of duplication and the parts that are different can go in
> the DT.

As I mentioned in the cover letter - that's the goal. My (minor) worry
is how to treat such file... The A5 and A9 are very similar indeed, but
A7/A15 are slightly different. So there would be "a5_and_a9.c" and
"a7_and_a15.c" and "64bit_chip.c"... I'll see how it works.

> > +                     uart0: uart at 090000 {
> 
> Use generic names:
> 
> s/uart/serial/

Ok, will do.

> > +     memory {
> 
> memory at 80000000

Ok.

> > +#ifdef CONFIG_SMP
> > +static void v2p_ca5s_init_cpu_map(void)
> > +{
> > +     int i, ncores = scu_get_core_count(V2TILE_PERIPH_P2V(A5_MPCORE_SCU));
> 
> This works on A9, does it work on A5? 
> 
>         /* Get SCU base */
>         asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));

Cool, didn't know about this :-) And as this is a PERIPHBASE value
(http://infocenter.arm.com/help/topic/com.arm.doc.ddi0407g/CACCJFCJ.html) it could help with TWD as well. 

> If not, an SCU binding should be created.

I'll do one or the other.

Thanks!

Pawel
