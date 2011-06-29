From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Wed, 29 Jun 2011 16:52:56 +0200
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <alpine.DEB.2.00.1106151349520.11405@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>	<20110613122601.GC12325@n2100.arm.linux.org.uk>	<alpine.DEB.2.00.1106131400090.25153@localhost6.localdomain6>	<20110613164452.GE13643@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106151349520.11405@localhost6.localdomain6>
Message-ID: <4E0B3C48.1060101@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frank Hofmann a ?crit :
> On Mon, 13 Jun 2011, Russell King - ARM Linux wrote:
> 
> Hi Russell,
> 
> 
> this change is perfect; with this, the hibernation support code turns into 
> the attached.
> 
> That's both better and simpler to perform a full suspend/resume cycle (via 
> resetting in the cpu_suspend "finisher") after the snapshot image has been 
> created, instead of shoehorning a return into this.
> 
> FrankH.


> 
> +
> +u8 __swsusp_resume_stk[PAGE_SIZE/2] __nosavedata;
It look like dangerous : there is no alignment constraint, but the stack should
be aligned on a 8 Bytes.


Matthieu
