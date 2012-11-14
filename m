From: etienne.carriere@st.com (Etienne CARRIERE ST)
Date: Wed, 14 Nov 2012 12:02:24 +0100
Subject: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ
In-Reply-To: <20121114105049.GI3290@n2100.arm.linux.org.uk>
References: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>
 <20121113170711.GI28327@n2100.arm.linux.org.uk>
 <0154077FE026E54BB093CA7EB3FD1AE32B57AF1E29@SAFEX1MAIL3.st.com>
 <20121114102127.GH3290@n2100.arm.linux.org.uk>
 <0154077FE026E54BB093CA7EB3FD1AE32DB61E4D23@SAFEX1MAIL3.st.com>
 <20121114105049.GI3290@n2100.arm.linux.org.uk>
Message-ID: <0154077FE026E54BB093CA7EB3FD1AE32DB6A62AC7@SAFEX1MAIL3.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Thanks for notifying. I will look at the recent release to see if our 
> > architecture complies with Kernel code.
> > 
> > Our mutex implementation is based on 0/1 lock/unlock value in target 
> > mutex DDR cell.
> 
> Right, so we have another bug here: it is incompatible with the current ARM 
> spinlock implementation - and using it on the same memory location as a 
> spinlock will corrupt the spinlock.

Right.
I see our architecture complies with kernels before v3.6-rc1.
Until then, it seems we can use our patch, but we must plan something else for the more recent kernels.

etienne
