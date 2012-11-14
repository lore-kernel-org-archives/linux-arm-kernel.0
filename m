From: etienne.carriere@st.com (Etienne CARRIERE ST)
Date: Wed, 14 Nov 2012 11:45:42 +0100
Subject: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ
In-Reply-To: <20121114102127.GH3290@n2100.arm.linux.org.uk>
References: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>
 <20121113170711.GI28327@n2100.arm.linux.org.uk>
 <0154077FE026E54BB093CA7EB3FD1AE32B57AF1E29@SAFEX1MAIL3.st.com>
 <20121114102127.GH3290@n2100.arm.linux.org.uk>
Message-ID: <0154077FE026E54BB093CA7EB3FD1AE32DB61E4D23@SAFEX1MAIL3.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Sent: Wednesday, November 14, 2012 11:21 AM
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
>
> > > Right, so, what this tells me is that the implementation of the 
> > > spinlock in the secure software is potentially the same as the 
> > > kernel's spinlock.
> > > The kernel's spinlock implementation is GPL'd.  If the secure side 
> > > spinlock implementation is a copy of the kernel's spinlock 
> > > implementation, then that implementation is also GPL'd (...).
> > > 
> > > I think someone has some explaining to do.
> > 
> > It does.
> > 
> > The TZ implementation of the shared mutex is the ARM native mutex 
> > instructions set LDREX/STREX, protected by a native ARM IRQ disabling.
> > I believe this is native ARMv7 natural handling and not subject to 
> > GPLization.
>
> Maybe, maybe not.  There's more to locking than just the instructions used 
> - there's the values which are used to represent "locked" and "unlocked", 
> and then there's the ticket locking implementation found in recent kernels 
> which defines the value to have more meaning than just "locked" and "unlocked".
>
> With ticket locking, you need to know the details of the implementation to be 
> able to lock successfully, and that basically means copying the implementation.

Thanks for notifying. I will look at the recent release to see if our architecture complies with Kernel code.

Our mutex implementation is based on 0/1 lock/unlock value in target mutex DDR cell.

etienne 
