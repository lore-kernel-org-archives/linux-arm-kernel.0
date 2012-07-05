From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 5 Jul 2012 13:42:31 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <87liiyijb8.fsf@lebrac.rtp-net.org>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-2-git-send-email-andrew@lunn.ch>
 <20120705110251.596331e0@skate> <20120705094824.GO17534@lunn.ch>
 <87sjd6ikkj.fsf@lebrac.rtp-net.org> <20120705122050.2fbc2fe3@skate>
 <87liiyijb8.fsf@lebrac.rtp-net.org>
Message-ID: <20120705134231.3e1801e5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Thu, 05 Jul 2012 12:38:51 +0200,
Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> a ?crit :

> > The MPP registers are identical on Armada XP/370 and 88F6281 (not sure
> > which other SoC datasheet I should be checking). Basically, it's just a
> > range of contiguous registers, with 4 bits per pin to select the
> > function.
> 
> iirc, other SoCs are similar. The small exception being dove I
> guess. Dove has a 3rd gpo [the gpios are output only] bank but to be
> used as gpio require that a special bit is set and it's for all gpios of
> this bank. You'll find this bit in the "general mpp configuration
> register" if you look at the datasheet.

Ok, this is a bit trickier, but we can probably do something for it as
well.

> > So my pinmux driver should simply work as is for Orion as well. The
> > only difference between platforms is the number of MPP pins that are
> > available, but this number also varies between versions of Armada XP
> > and Armada 370, so I already support this in the driver.
> 
> Are there some output-only gpio on armada xp/370 like on kirkwood/dove ?

Yes. I am not sure yet how to describe those in the DT, or even if it
is actually useful to describe them. Wouldn't it be simpler to just
leave to the user of the GPIO to use a GPIO that's appropriate for its
usage, i.e not use a GPO when input is needed?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
