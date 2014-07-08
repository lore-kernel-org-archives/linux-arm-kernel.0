From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Jul 2014 13:12:52 +0100
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <20140708115727.GR23978@titan.lakedaemon.net>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140708053434.GH28931@quad.lixom.net>
 <20140708115727.GR23978@titan.lakedaemon.net>
Message-ID: <20140708121252.GK21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 07:57:27AM -0400, Jason Cooper wrote:
> Can you offer any suggestions as to how you would like this resolved?  I
> thought when I voiced my opinion as above, and Russell didn't reply,
> there was implied acknowledgement...

I didn't reply probably because I didn't see the message and/or I'm busy
with other stuff.

I know that Sebastian asked Rabeeh on IRC yesterday whether the flash
chip type could be used to detect the difference between the two, but
has not yet received an answer.

As the two DT descriptions are mutually incompatible, there isn't much
choice.  And (afaik) there's no choice of updating the boot loader to
a version which can deal with DT - yes it may be u-boot, but I've no
idea if modern u-boot works on it, and I really would not like to try.

While SolidRun tried to make changing u-boot easy and recoverable, I've
had personal experience of trying to help people restore their cuboxes.
It's a total nightmare (mainly seems to be down to the wide variation
in USB hardware which causes the on-board USB-serial for the console to
be unreliable.)  That's why on their later iMX6 hardware (Cubox-i & HB)
they decided to have zero on-board non-volatile storage.

So, even if it was possible to detect the difference in u-boot between
the Cubox models, getting the updated u-boot on the machine is far from
trivial.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
