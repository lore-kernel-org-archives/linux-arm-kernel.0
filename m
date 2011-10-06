From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 06 Oct 2011 16:00:47 +0100
Subject: [PATCH] arm: Add VIRTUALIZATION configuration menu and virtio
	options
In-Reply-To: <20111006144601.GE26349@n2100.arm.linux.org.uk>
References: <1317224886-3925-1-git-send-email-pawel.moll@arm.com>
	<20111006144601.GE26349@n2100.arm.linux.org.uk>
Message-ID: <1317913247.28696.97.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > This patch adds menuconfig VIRTUALIZATION to arm Kconfig
> > and includes virtio Kconfig in it.

I had another look and it's actually not needed any more, as since
e72542191cbba4cf7fda21cb22e26b42d7415daf "virtio: expose for
non-virtualization users too" the drivers/virtio/Kconfig is included in
drivers/Kconfig.

> Please resubmit without the line above.  default n is default's default
> default, so it's completely redundant by default.

We have 606 redundant defaults then:

$ find . -name Kconfig\* | xargs grep "default n" | wc -l
606

Not something that would make me sleepless ;-)

Cheers!

Pawe?
