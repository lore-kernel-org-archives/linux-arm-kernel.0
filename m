From: metan@ucw.cz (Cyril Hrubis)
Date: Mon, 8 Mar 2010 14:32:21 +0100
Subject: bit errors on spitz
In-Reply-To: <20100308124248.GB12363@n2100.arm.linux.org.uk>
References: <20100305212708.GC21773@elf.ucw.cz>
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>
	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>
	<20100308082530.GA1982@atrey.karlin.mff.cuni.cz>
	<1268048916.6477.9.camel@utx.utx.cz>
	<20100308121634.GA14904@atrey.karlin.mff.cuni.cz>
	<20100308124248.GB12363@n2100.arm.linux.org.uk>
Message-ID: <20100308133221.GB14904@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> Is this display rotated by 90 degrees?

Yes it is.

> If so, they're actually horizontal lines as far as the display scanning
> is concerned - and that tends to suggest that there's insufficient system
> bus bandwidth for all the activity taking place, and the LCD controller
> is being starved of data.

Well, when doing 'echo 0 > /sys/class/graphics/fbcon/rotate_all' for 2.6.33
I've got the same problem but the lines are vertical. However 2.6.24 seems to
work in non rotated mode.

> I've seen similar (described) effects on SA1110 systems in past years
> with low clock rates.
> 
> Some of the reports suggest that this happens with multiple kernel versions
> and is not something new to the latest kernels.  Please confirm when the
> problem started.

As far as I can test in rotated mode it happens for kernels from 2.6.24 to
2.6.33 (I haven't older kernel than 2.6.24 that boots on spitz). 

-- 
metan
