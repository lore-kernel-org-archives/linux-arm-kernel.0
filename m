From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 28 Apr 2014 20:14:03 +0530
Subject: [patch V2 5/6] edma: Make reading the position of active channels
 work
In-Reply-To: <20140428104643.215725974@linutronix.de>
References: <20140428104416.464002156@linutronix.de>
 <20140428104643.215725974@linutronix.de>
Message-ID: <535E6933.2020509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 April 2014 04:19 PM, Thomas Gleixner wrote:

> As Joel pointed out, edma_read_position() uses memcpy_fromio() to read
> the parameter ram. That's not synchronized with the internal update as
> it does a byte by byte copy. We need to do a 32bit read to get a
> consistent value.
> 
> Further reading destination and source is pointless. In DEV_TO_MEM
> transfers we are only interested in the destination, in MEM_TO_DEV we
> care about the source. In MEM_TO_MEM it really does not matter which
> one you read.
> 
> Simple solution: Remove the pointers, select dest/source via a bool
> and return the read value.

> Remove the export of this function while at it. The only potential
> user is the dmaengine and that's always builtin.

While this is true today, there are other DMA drivers which
are modules.

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Irrespective of above,

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
