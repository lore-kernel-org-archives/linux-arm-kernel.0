From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 12:55:34 +0200
Subject: [PATCH v2 4/5] drivers: firmware: psci: add extended stateid
 power_state support
In-Reply-To: <20151023104457.GA9309@red-moon>
References: <1436375811-10529-1-git-send-email-lorenzo.pieralisi@arm.com>
 <3982126.UybqODJKJo@wuerfel> <20151023104457.GA9309@red-moon>
Message-ID: <7012327.dvizHt4W5S@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 October 2015 11:44:58 Lorenzo Pieralisi wrote:
> 
> Problem with Qemu emulation is that it does not emulate the PSCI 1.0
> specs correctly (it does not even consider PSCI 1.0 functions proper PSCI
> calls), I tested it and I think we should update Qemu as we
> did with KVM kernel code instead of working around it by dodging the
> problem in the PSCI implementation by adding code that checks the
> PSCI version before issuing the PSCI calls through the respective
> conduit.
> 
> Thoughts appreciated.

I think we really cannot break existing qemu installations, but need
a way to detect whether we are dealing with a broken qemu (and warn
about that) or with a working PSCI implementation.

Fixing qemu is of course a good idea, but it's not sufficient.

	Arnd
