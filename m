From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Mar 2010 12:42:48 +0000
Subject: bit errors on spitz
In-Reply-To: <20100308121634.GA14904@atrey.karlin.mff.cuni.cz>
References: <20100305212708.GC21773@elf.ucw.cz>
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>
	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>
	<20100308082530.GA1982@atrey.karlin.mff.cuni.cz>
	<1268048916.6477.9.camel@utx.utx.cz>
	<20100308121634.GA14904@atrey.karlin.mff.cuni.cz>
Message-ID: <20100308124248.GB12363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 08, 2010 at 01:16:35PM +0100, Cyril Hrubis wrote:
> Hi!
> > - And I see display noise while CF Wi-Fi card is active.
> 
> Forgotten about this one. See for yourself, notice short black vertical lines
> flashing randomly.

I haven't looked at the video.

Is this display rotated by 90 degrees?

If so, they're actually horizontal lines as far as the display scanning
is concerned - and that tends to suggest that there's insufficient system
bus bandwidth for all the activity taking place, and the LCD controller
is being starved of data.

I've seen similar (described) effects on SA1110 systems in past years
with low clock rates.

Some of the reports suggest that this happens with multiple kernel versions
and is not something new to the latest kernels.  Please confirm when the
problem started.
