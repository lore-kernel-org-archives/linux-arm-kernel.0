From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 Jun 2014 12:17:56 +0100
Subject: [PATCH 3.10 005/103] irqchip: Gic: Support forced affinity setting
In-Reply-To: <20140605180524.GC4121@kroah.com>
References: <20140604232546.704156131@linuxfoundation.org>
 <20140604232547.006861681@linuxfoundation.org>
 <20140605160500.GD31564@leverpostej>
 <20140605180524.GC4121@kroah.com>
Message-ID: <20140623111756.GY24291@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 11:05:24AM -0700, Greg Kroah-Hartman wrote:
> On Thu, Jun 05, 2014 at 05:05:00PM +0100, Mark Rutland wrote:

> > This patch alone has the possiblity of breaking CPU hotplug on arm and
> > arm64 (specifically it breaks hot unplugging CPU0 where interrupts may
> > be left targetting the offline CPU).

...

> > Unfortunately there is not an equivalent fix for arm - Russell objected
> > to the approach [2,3,4], and that's not yet settled.

> Ok, be sure to cc: stable on the patch when it goes into the tree and
> I'll pick it up then.

Sadly that fix still hasn't materialised so stable remains broken for
ARM.  The discussion was restarted on Friday but Russell is looking to
Thomas for input.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140623/171b1286/attachment.sig>
