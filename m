From: utx@penguin.cz (Stanislav Brabec)
Date: Thu, 11 Mar 2010 16:42:35 +0100
Subject: bit errors on spitz
In-Reply-To: <4B98EF5D.5000609@warmcat.com>
References: <20100305212708.GC21773@elf.ucw.cz>
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>
	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>
	<20100308082530.GA1982@atrey.karlin.mff.cuni.cz>
	<4B98EF5D.5000609@warmcat.com>
Message-ID: <1268322155.3990.114.camel@hammer.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andy Green wrote:

> I saw very similar failures for a long time on our iMX31 based device. 
> Eventually I found a Freescale errata where the RAM inside the USB2 
> macrocell started to make single bit errors below 1.38V Vcore; ours was 
> 1.4V at that time but dipped on CPU load.

Good tip. It seems that nobody ported driver for the voltage control
chip ISL6271 from 2.4 kernel, and bootloader probably does not set
correct values.

Datasheet:
http://www.penguin.cz/~utx/zaurus/datasheets/power/Xscale/ISL6271.pdf

-- 
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
