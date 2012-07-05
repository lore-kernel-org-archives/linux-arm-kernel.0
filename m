From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 5 Jul 2012 12:20:50 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <87sjd6ikkj.fsf@lebrac.rtp-net.org>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-2-git-send-email-andrew@lunn.ch>
 <20120705110251.596331e0@skate> <20120705094824.GO17534@lunn.ch>
 <87sjd6ikkj.fsf@lebrac.rtp-net.org>
Message-ID: <20120705122050.2fbc2fe3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Thu, 05 Jul 2012 12:11:40 +0200,
Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> a ?crit :

> > You are not the only one working in this area. Arnaud Patard said he
> > was look at this as well. 
> 
> yeah, but tbh I've not made anything yet. If Thomas has already some
> code for it, we should try to make it "generic" so as to use it on
> armada xp and orion platforms.

The MPP registers are identical on Armada XP/370 and 88F6281 (not sure
which other SoC datasheet I should be checking). Basically, it's just a
range of contiguous registers, with 4 bits per pin to select the
function.

So my pinmux driver should simply work as is for Orion as well. The
only difference between platforms is the number of MPP pins that are
available, but this number also varies between versions of Armada XP
and Armada 370, so I already support this in the driver.

However, using the pinmux driver will require changes in the device
drivers, so that they request the pinmux for their devices.

> > I know Marvell has contracted you to port to Armada 370/XP, not mvebu,
> > aka all chips which might be able to share this code. This IMHO is
> > wrong. So i personally would put the kirkwood and the Armada 370/XP
> > data sheets next to each other, and from the beginning on write the
> > driver so it supports them all. This assumes the ASIC engineers have
> > not radically changed anything... Please also try to stick to the DT
> > binding i've used.
> 
> agreed. it should be written with all platforms in mind, as long as
> they're compatible. It can only make things better imho.

Certainly, especially for MPP/GPIO that are definitely very similar.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
