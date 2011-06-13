From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2011 09:20:44 +0100
Subject: [PATCH 0/6] footbridge consolidation patches
In-Reply-To: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
References: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <20110613082044.GA9393@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 02:39:39PM +0800, Bryan Wu wrote:
> When trying to convert old leds event driver to led trigger drivers, I reviewed
> the code of mach-footbridge. move seperated PCI code and leds code into a
> single board files like other machines.

This looks like it breaks all these when CONFIG_PCI=n.  In that case,
we would avoid building the PCI supporting files.  However, with your
merged files, we build it anyway and end up with undefined calls to
the PCI subsystem.

The code is separated to avoid that, and to avoid ifdefs.

I'm not entirely sure what the point of this patch set is, because it
mostly just moves the code into one file per platform and doesn't
consolidate anything between the platforms themselves.
