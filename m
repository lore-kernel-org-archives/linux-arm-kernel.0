From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 10:30:01 +0000
Subject: [RFC 0/5] restart cleanups
In-Reply-To: <2088587985.4382541320219966553.JavaMail.root@zimbra20-e3.priv.proxad.net>
References: <1676495226.4381981320219764753.JavaMail.root@zimbra20-e3.priv.proxad.net>
	<2088587985.4382541320219966553.JavaMail.root@zimbra20-e3.priv.proxad.net>
Message-ID: <20111102103001.GX19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 08:46:06AM +0100, Robert Jarzmik wrote:
> ----- Mail Original -----
> De: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
> > We do have this problem - mioa701 - which insists on doing things like
> > kfree, free_irq, gpio_free in this path, which is a bad idea as it can
> True. You mean gsm_exit() and bootstrap_exit() I think.
> These were added to free resources in a shutdown. If freeing is pointless,
> in a reboot case, and stale resources don't matter, well, we can kill these
> 2 functions.

Provided you're talking about software state only, then it is pointless
because the state of the system software will be lost on reboot anyway.
