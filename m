From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Thu, 8 Jan 2015 13:10:08 +0000
Subject: [PATCH] serial: 8250: Make ISA ports optional
In-Reply-To: <1420513785-23660-1-git-send-email-peter@hurleysoftware.com>
References: <1420513785-23660-1-git-send-email-peter@hurleysoftware.com>
Message-ID: <20150108131008.16c9a31c@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  5 Jan 2015 22:09:45 -0500
Peter Hurley <peter@hurleysoftware.com> wrote:

> Some arches have no need to create unprobed 8250 ports; these phantom
> ports are primarily required for ISA ports which have no probe
> mechanism or to provide non-operational ports for userspace to
> configure (via TIOCSSERIAL and TIOCSERCONFIG ioctls).
> 
> Provide CONFIG_SERIAL_8250_PHANTOM_UARTS knob to disable phantom port
> registration; ie., CONFIG_SERIAL_8250_PHANTOM_UARTS=N only registers
> probed ports (ACPI/PNP, "serial8250" platform devices, PCI, etc).

Just #define serial8250_isa_devs to 0 on such platforms. gcc should then
be bright enough to do the rest for you.
