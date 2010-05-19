From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 19 May 2010 21:08:19 +0100
Subject: Boot interface for device trees on ARM
In-Reply-To: <alpine.LFD.2.00.1005191055180.12758@xanadu.home>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<AANLkTilJl9_NHiT1LITG7UbA9S7OYsnGMcDAsFEEx5Ob@mail.gmail.com>
	<alpine.LFD.2.00.1005191055180.12758@xanadu.home>
Message-ID: <20100519200819.GF1693@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> It is not up to the bootloader to "adjust" to the kernel.  But rather 
> for the kernel to cope with the bootloader's provided information.  If 
> the bootloader passes a specific machine ID with the ATAG list then the 
> kernel will use that, and if the bootloader passes a DT machine ID with 
> a DT blob then the kernel will use that.  You just have to configure 
> your kernel with both "machine types" at the same time.

Scenario:

You upgrade your systems to a new DT-capable kernel and DT-capable
bootloader.  It works great.  You ship new instances of your device with this.

Once they're in the field, someone reports a bug that doesn't happen
with the older device instances.  It's not a bug you can reproduce,
but you suspect the newer of kernel.  So you remote-update some of the
newly shipped devices with an old, pre-DT kernel binary that's been
stable on the older devices, to see if the bug goes away.

Problem: The newer shipped devices have a DT-capable bootloader, and
it can't boot old kernels, because they don't understand the DT format.

You could remote-downgrade the bootloaders, but that's risky.  You
could try building the old kernel with DT support, but that adds
another variable to your testing.

Anticipating this well in advance, you of course built your DT-capable
bootloader with the ability to boot old and new style kernels...

-- Jamie
