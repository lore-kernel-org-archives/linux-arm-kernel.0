From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 15:21:49 +0100
Subject: error: implicit declaration of function 'machine_is_ventana'
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B24A3789@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF04B24A376A@HQMAIL01.nvidia.com>
	<20110822234008.GC3895@n2100.arm.linux.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A377F@HQMAIL01.nvidia.com>
	<20110823000135.GD3895@n2100.arm.linux.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3789@HQMAIL01.nvidia.com>
Message-ID: <20110823142149.GJ19622@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 05:11:54PM -0700, Stephen Warren wrote:
> Russell King wrote at Monday, August 22, 2011 6:02 PM:
> > Any entry not marked as being present in mainline will be removed after
> > 12 months after it was last touched - which apparantly was 18th June
> > 2010.
> 
> Ah, that I can understand.
> 
> > So, the questions are:
> > 1. why do we have driver code merged for a platform which shows no sign
> >    of being merged.
> 
> Well, I or someone probably would have pushed Ventana support into
> mainline within the last few months, since it's pretty similar to Harmony
> and Seaboard which are both already supported. However, I've been holding
> due to the no-new-board-files thing, until Device-Tree gets fully baked,
> and we can then support the board just by adding a simple .dts file.
> 
> > 2. why do we have drivers depending on their platform anyway.
> 
> The ASoC subsystem defines a "machine driver", which defines facets of
> the audio system such as which pins on the audio codec are connected to
> the headphone jack. This varies between boards, so the "machine driver"
> picks the appropriate routing table at run-time based on the board that
> the code is running on. Arguably, one could represent all this data in
> board files using platform data, but IIUC, the ASoC maintainers prefer
> to keep it all centralized in the sound directory tree.
> 
> I understand from Grant Likely that John Bonesio will be posting a patch
> in the very near future to retrieve all this data from Device Tree, so
> this won't be an issue moving forward, given that Tegra will probably
> switch to Device Tree pretty aggressively.
> 
> Still, I suppose we could rip out explicit support for Ventana in the
> sound driver in the interim if you want, rather than adding back the
> Ventana machine definition.

Given that you're the second one to report breakage, I think it's probably
better if I drop the mach-types update from my 'fixes' branch, and punt
it into the stuff for the next merge window.

That means that the PXA stuff which was inappropriately merged without
its mach-type entry will stay broken until after the next merge window.
Unfortunate, but I'm not seeing much other option other than me having
to put lots of time into manually sorting out a mach-types update (which
I don't have the time nor motivation to do at the moment.)
