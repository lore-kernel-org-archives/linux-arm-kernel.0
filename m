From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Apr 2010 19:14:58 +0100
Subject: Query: ARM Cortex A9: Is invalidating L1 data cache mandatory
	before usage
In-Reply-To: <4BC985BD.8040704@st.com>
References: <4BC985BD.8040704@st.com>
Message-ID: <20100417181457.GA24299@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 17, 2010 at 03:26:13PM +0530, Shiraz HASHIM wrote:
> Hello,
> 
> I am trying to port Linux on ARM Cortex A9 based platform and what
> I see is that if I don't invalidate the data cache before enabling
> and using it (in arch/arm/boot/compressed/head.S) the system crashes.
> 
> I need to do the same for second core before calling secondary_startup.
> 
> Is it normal? Why then other platforms (cortex A9 based) are not doing
> this. What am I missing?

Yes, it's required.  See:

http://www.arm.linux.org.uk/developer/booting.php
