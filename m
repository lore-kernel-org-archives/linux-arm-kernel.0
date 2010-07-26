From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Jul 2010 10:26:12 -0500
Subject: [PATCH v2] ARM: Stop secondary cpus in machine_halt()
In-Reply-To: <20100726123113.GC23399@n2100.arm.linux.org.uk>
References: <20100701224706.GA26473@lixom.net>
	<20100703184614.GA9693@lixom.net>
	<20100712164810.GB9897@n2100.arm.linux.org.uk>
	<20100726123113.GC23399@n2100.arm.linux.org.uk>
Message-ID: <20100726152612.GA13864@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 26, 2010 at 01:31:13PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 12, 2010 at 05:48:10PM +0100, Russell King - ARM Linux wrote:
> > Hmm... what about kexec on a SMP system, or we try to reboot a SMP
> > system?
> > 
> > The x86 code suggests that we put smp_send_stop() inside
> > machine_shutdown() (and move that function into arch/arm/kernel/process.c)
> > and call it from machine_halt() and machine_reboot().
> > 
> > This will cover the kexec and reboot cases too.
> 
> As no one's commented on this, I'm going to apply it later today for
> the next merge window - it seems to be the right way to solve this
> problem, and makes us reflect what x86 does.

Yeah, looks good to me.

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
