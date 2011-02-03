From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 03 Feb 2011 18:26:44 -0500 (EST)
Subject: [PATCH RFC] ARM: Make VMALLOC_END a variable
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310C8E8E3@HQMAIL01.nvidia.com>
References: <AANLkTinadBvmnjN=kUt82e=hmM0xumFs8WP_ca8V-e8Y@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310C8E8E3@HQMAIL01.nvidia.com>
Message-ID: <alpine.LFD.2.00.1102031704330.12104@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Feb 2011, Stephen Warren wrote:

> It seems slightly unfortunate to replace a single define per SoC with a
> cut/paste copy of the value in every machine description. At least for Tegra,
> there's only a single machine description right now, but I can foresee a great
> many more in the future.
[...]
> Alternatively, can tegra_harmony_init (which calls tegra_common_init) set
> this up during initialization, or is the value needed earlier than that?

It is needed earlier than that.

And even then, given the number of supported machines, it would be hard
to make custom changes for each of them along the lines of what you 
suggest.
Also, given that each machine can already have different static IO 
mappings via their map_io method in the machine record, and since the 
vmalloc space is often limited to where the static IO mappings start, it 
therefore makes sense to put them close together.

> Alternatively, perhaps there should be a SoC definition similar to the machine
> Definition, which defines this, and the machine definitions point at the SoC
> definition? I don't know if this is worth it; is there other information that
> could usefully be placed in such a SoC definition?

That's indeed one of the plans.  Yes, there are other things that often 
are shared across all machines with the same SOC.  But we want to go 
with the simple cleanups first and eventually those things could be 
rationalized.

> Either way, I won't object strongly to this, but just some food for thought.

Don't worry -- this has been suggested already by Eric 
himself and discussed again about 2 weeks ago.


Nicolas
