From: leif.lindholm@arm.com (Leif Lindholm)
Date: Fri, 29 Jan 2010 12:17:18 -0000
Subject: ARM11 MPCore: Adding nop to __delay() doubles the BogoMIPS/lpj
In-Reply-To: <4B606D92.9020005@googlemail.com>
References: <4B606D92.9020005@googlemail.com>
Message-ID: <000001caa0dd$00b21d90$021658b0$@lindholm@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Dirk Behme
> Sent: 27 January 2010 16:45

> On a 400MHz ARM11 MPCore system (NEC NaviEngine based) with kernel
> 2.6.32 we found that BogoMIPS/loops per jiffies ~doubles (see below
> [1]) by adding a nop to __delay():

The reason for this is that the ARM11 MPCore doesn't fold branch
instructions for busy-wait-style loops. Inserting the nop (or any other
non-branch instruction) removes the branch instruction from the
execution stream.
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0360f/ch06s02s04.html

But as Catalin says, this makes no functional difference, even though it
might look "more impressive" :)

/
	Leif
