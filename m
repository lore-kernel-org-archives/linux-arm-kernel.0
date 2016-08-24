From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Aug 2016 10:26:47 +0100
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
In-Reply-To: <57bd659d.0f4d190a.e025.5da4@mx.google.com>
References: <57bd659d.0f4d190a.e025.5da4@mx.google.com>
Message-ID: <20160824092647.GH1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 12:15:07PM +0300, radioconfusion at gmail.com wrote:
> The problem caused by my mistake, I was using the following kernel parameter:
> mem=1048448k

Try mem=1046M - reducing it by 2MB.  If that works, try mem=1047M
instead.  Yes, that's more than you want to reserve, but please
check how the system behaves with these.

> My device has 1 GiB of RAM and I tried to reserve 128 kiB of memory for ram
> oops. I guess this parameter caused overlapping or inaccessible area with cesa's
> addresses. Am I right?
> I tried to add memmap=0x20000$0x3ffe0000 without success.

memmap= has no meaning on ARM.  It's an x86 thing, the ARM arch has
never implemented it.  I've seen this come up a few times, and I don't
know why people keep trying to use it (always with an "it doesn't seem
to work" result.)  It's even documented as being an ACPI / x86 thing
in Documentation/kernel-parameters.txt...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
