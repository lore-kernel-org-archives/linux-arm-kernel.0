From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 1 Mar 2011 21:37:51 -0500 (EST)
Subject: [PATCH 1/4] ARM:boot:device tree: Allow the device tree binary
	to be appended to zImage
In-Reply-To: <4D6DA062.8010904@secretlab.ca>
References: <20110228233153.24836.24176.stgit@riker>
	<20110228233327.24836.94530.stgit@riker>
	<alpine.LFD.2.00.1103010019160.10356@xanadu.home>
	<4D6DA062.8010904@secretlab.ca>
Message-ID: <alpine.LFD.2.00.1103012124320.9350@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Mar 2011, John Bonesio wrote:

> I have looked through, and I'm reworking the patch set. I have just one
> comment below.
> 
> - John
> 
> On 02/28/2011 10:39 PM, Nicolas Pitre wrote:
> > On Mon, 28 Feb 2011, John Bonesio wrote:
> > 

[...]

> >> +
> >> +		/* bump our bss registers too */
> >> +		add	r2, r2, r5
> >> +		add	r3, r3, r5
> >> +
> >> +		/* bump the stack pinter, if at or above _edata */
> >> +		cmp	sp, r6
> >> +		addcs	sp, sp, r5
> > 
> > This will always be true as this is within #ifndef CONFIG_ZBOOT_ROM.
> 
> Right now sp will always be above r6. I thought it might be prudent to
> add the test in case the linker script changed and the stack was placed
> elsewhere. It might save someone a headache later.

That's what comments are for.  And if someone modifies the linker script 
without understanding the affected code then that someone deserves the 
pain.


Nicolas
