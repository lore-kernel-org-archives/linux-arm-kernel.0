From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Oct 2013 11:46:12 +0100
Subject: [PATCH 01/11] usb: chipidea: Add power management support
In-Reply-To: <20131014090420.GB26191@shlinux1.ap.freescale.net>
References: <1381570513-24927-1-git-send-email-peter.chen@freescale.com>
 <1381570513-24927-2-git-send-email-peter.chen@freescale.com>
 <20131014100458.4f577d01@ipc1.ka-ro>
 <20131014075547.GA26191@shlinux1.ap.freescale.net>
 <20131014084216.GY30088@pengutronix.de>
 <20131014090420.GB26191@shlinux1.ap.freescale.net>
Message-ID: <20131014104612.GK25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 05:04:21PM +0800, Peter Chen wrote:
> It is for ARM, but for other platforms, it may not.

Wrong.  atomic_read() and atomic_set() are defined the same way and
have the same lack of atomicity across all architectures.  There is
nothing special about these over a standard load/store.  Your code
using this is quite simply broken and founded on false assumptions
about these macros.
