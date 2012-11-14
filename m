From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Nov 2012 10:50:49 +0000
Subject: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ
In-Reply-To: <0154077FE026E54BB093CA7EB3FD1AE32DB61E4D23@SAFEX1MAIL3.st.com>
References: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>
 <20121113170711.GI28327@n2100.arm.linux.org.uk>
 <0154077FE026E54BB093CA7EB3FD1AE32B57AF1E29@SAFEX1MAIL3.st.com>
 <20121114102127.GH3290@n2100.arm.linux.org.uk>
 <0154077FE026E54BB093CA7EB3FD1AE32DB61E4D23@SAFEX1MAIL3.st.com>
Message-ID: <20121114105049.GI3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 11:45:42AM +0100, Etienne CARRIERE ST wrote:
> Thanks for notifying. I will look at the recent release to see if our
> architecture complies with Kernel code.
> 
> Our mutex implementation is based on 0/1 lock/unlock value in target
> mutex DDR cell.

Right, so we have another bug here: it is incompatible with the current
ARM spinlock implementation - and using it on the same memory location
as a spinlock will corrupt the spinlock.
