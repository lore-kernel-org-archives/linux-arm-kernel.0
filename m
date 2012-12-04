From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Dec 2012 13:10:27 -0500 (EST)
Subject: [RFC PATCH 2/2] ARM: SMP support for mach-virt
In-Reply-To: <20121204171628.GF5314@mudshark.cambridge.arm.com>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <1354557160-20144-3-git-send-email-will.deacon@arm.com>
 <50BD1FD7.9040000@gmail.com>
 <20121204124047.GM23368@mudshark.cambridge.arm.com>
 <20121204133326.GE14363@n2100.arm.linux.org.uk>
 <20121204134010.GP23368@mudshark.cambridge.arm.com>
 <20121204143724.GF14363@n2100.arm.linux.org.uk>
 <20121204161113.GT23368@mudshark.cambridge.arm.com>
 <50BE28C6.2010403@gmail.com>
 <20121204171628.GF5314@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1212041306560.6589@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Dec 2012, Will Deacon wrote:

> On Tue, Dec 04, 2012 at 04:45:58PM +0000, Rob Herring wrote:
> > If there is no way to reset the core, then couldn't the hotplug code
> > tear down the cpu setup and just jump back to 0x0 which then returns to
> > the bootloader's pen?
> 
> I think hotplug really should be implemented with a virtio device. We just
> trap back to the emulation and kill the vcpu thread.

Hotplug and secondary boot should really be considered the same and use 
the same methods.  So if you envision a virtio device for hotplug, then 
just use that for secondary boot as well.  PSCI might be simpler to 
implement though.


Nicolas
