From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 May 2010 00:08:41 +0100
Subject: Rampant ext3/4 corruption on 2.6.34-rc7 with VIVT ARM (Marvell
	88f5182)
In-Reply-To: <1273704431.21352.136.camel@pasglop>
References: <1273569821.21352.19.camel@pasglop>
	<1273575478.21352.29.camel@pasglop>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C545537F@dbde02.ent.ti.com>
	<20100512222154.GA6841@shareable.org>
	<1273704431.21352.136.camel@pasglop>
Message-ID: <20100512230841.GA10090@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 08:47:11AM +1000, Benjamin Herrenschmidt wrote:
> Now, in the case at hand, which is my ARM based NAS, I believe this
> is non cache-coherent and thus uses cache flush ops. I don't know ARM
> well enough but I would expect these to be implicit barriers. Russell ?
> Nico ?

ARMv5 doesn't have a weak memory ordering model, and doesn't have any
memory barrier instructions.
