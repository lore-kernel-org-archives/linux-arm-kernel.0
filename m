From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Feb 2011 08:19:40 -0800
Subject: [RFC 5/5] ARM: P2V: extend to 16-bit translation offsets
In-Reply-To: <20110105001359.GH24935@n2100.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDPu-00023p-QG@rmk-PC.arm.linux.org.uk>
	<8yabp3wfeax.fsf@huya.qualcomm.com>
	<20110105001359.GH24935@n2100.arm.linux.org.uk>
Message-ID: <20110207161940.GI20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110104 16:27]:
> On Tue, Jan 04, 2011 at 03:18:46PM -0800, David Brown wrote:
> > On Tue, Jan 04 2011, Russell King - ARM Linux wrote:
> > 
> > > MSM's memory is aligned to 2MB, which is more than we can do with our
> > > existing method as we're limited to the upper 8 bits.  Extend this by
> > > using two instructions to 16 bits, automatically selected when MSM is
> > > enabled.
> > 
> > I should also add that this series adds a warning to my build when
> > CONFIG_ARM_PATCH_PHYS_VIRT is not defined:
> > 
> >   arch/arm/kernel/module.c:279: error: 'find_mod_section' defined but not used
> 
> Hmm, probably best to mark this with __maybe_unused.
> 
> Also note that I messed up the 16-23 bit shift value in this patch - it
> needs:
> 
> -	orr	r0, r0, #0x400  @ mask in rotate right 8 bits
> +	orr	r0, r0, #0x800  @ mask in rotate right 16 bits
> 

Can't really test this one, but things still keep working so:

Acked-by: Tony Lindgren <tony@atomide.com>
