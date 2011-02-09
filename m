From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Feb 2011 13:06:45 +0000
Subject: [RFC 4/5] ARM: P2V: introduce phys_to_virt/virt_to_phys
	runtime patching
In-Reply-To: <20110209121701.GD2818@pulham.picochip.com>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDPa-00023l-CR@rmk-PC.arm.linux.org.uk>
	<20110209121701.GD2818@pulham.picochip.com>
Message-ID: <20110209130645.GC5544@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 09, 2011 at 12:17:01PM +0000, Jamie Iles wrote:
> I haven't been using the runtime patching, but building picoxcell based 
> off of todays next I'm seeing a pretty harmless warning.  Fixup below.

One of the reasons I've not done this is that it turns out that we
need to do the smp-on-up fixups on modules when running with certain
configs.  That means we need this function in other circumstances too.

It's probably going to be better to mark it with __maybe_unused than
to surround stuff with complex ifdefs.
