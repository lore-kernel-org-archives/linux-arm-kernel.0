From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 2 Jul 2015 16:20:59 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <267A46E7-C5C5-4696-90CC-D44F4130B3EF@smart-africa.com>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
 <267A46E7-C5C5-4696-90CC-D44F4130B3EF@smart-africa.com>
Message-ID: <20150702142058.GA9349@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 02, 2015 at 08:05:26AM +0100, Michael van der Westhuizen wrote:
> Ultimately, the numbering is inconsequential to users in kernel-space when DT is
> in use.  It?s the userland users we?re trying to help.

Yes.  Lets help the users!
 
> In my case, I have quite a lot of vendor-supplied code that needs the numbers to
> be stable and backward compatible.  This quickly devolves into a discussion of
> GPIOs in sysfs as an ABI, which is not a discussion I want to have :)

In the present state, the gpio numbers on the Altera socfpga change
with changing kernel releases.  Not only does that suck, but it also
proves that the gpio numbering is not any kind of ABI.  Rather, it is
some kind of oversight.

Anyhow, the whole point is, when the data sheet says that the SoC has
GPIO0 to GPION, then those numbers should be exposed to user space.

Thanks,
Richard
