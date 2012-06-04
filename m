From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Jun 2012 11:27:48 +0100
Subject: [PATCH] slimbus: Linux driver framework for SLIMbus.
In-Reply-To: <74993ac9d11db0db7080c0864daef397.squirrel@www.codeaurora.org>
References: <1338340310-4473-1-git-send-email-sdharia@codeaurora.org>
 <20120601001617.GA16311@plastictigers.com>
 <74993ac9d11db0db7080c0864daef397.squirrel@www.codeaurora.org>
Message-ID: <20120604102747.GC7538@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2012 at 03:21:06AM -0700, Sagar Dharia wrote:

> > b) Similarly to (a) the driver may be probed before the device has
> > been given a logical address (LA). This makes sense in the case of
> > driver that turns on the device (say via gpio) once the bus has
> > booted. However, the driver then needs to sit and poll
> > slim_get_logical_addr() until the logical address.

> This is not the case anymore.
> While taking care of the comments for RFC, I have introduced a completion
> that will be signalled when LA is given to the device. The driver can wait
> on that completion (wait_enum) instead of polling.

This would mean that the thread the probe is happening in will be
blocked until the LA is assigned.  That sounds like it might cause
problems, either slowing things down or worst case causing a deadlock.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120604/56d38981/attachment.sig>
