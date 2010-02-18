From: oliver@neukum.org (Oliver Neukum)
Date: Thu, 18 Feb 2010 07:56:14 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03216236D6@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF84D1@dbde02.ent.ti.com>
	<Pine.LNX.4.44L0.1002171201190.1913-100000@iolanthe.rowland.org>
	<5A47E75E594F054BAF48C5E4FC4B92AB03216236D6@dbde02.ent.ti.com>
Message-ID: <201002180756.14100.oliver@neukum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 17. Februar 2010 21:30:24 schrieb Gadiyar, Anand:
> > Why do you skip mapping the setup packet but not the data packet?
> > 
> 
> I think that's oversight. For this controller, we need to skip mapping
> all buffers used to do transfers on EP0, which is all control transfers.

One thing more. Do you have an issue with EP 0 only or all control
endpoints? EP 0 must be control, but devices are within spec if they
have multiple control endpoints provided EP 0 is control.

	Regards
		Oliver
