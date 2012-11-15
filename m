From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Nov 2012 13:55:55 +0000
Subject: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ
In-Reply-To: <0154077FE026E54BB093CA7EB3FD1AE32DB6A63266@SAFEX1MAIL3.st.com>
References: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>
 <20121113171745.GA6370@linaro.org>
 <BLU002-W44C55773365E0FDAC8B3C5E36C0@phx.gbl>
 <0154077FE026E54BB093CA7EB3FD1AE32DB61E4CC7@SAFEX1MAIL3.st.com>
 <20121114172216.GG16215@arm.com>
 <0154077FE026E54BB093CA7EB3FD1AE32DB6A63266@SAFEX1MAIL3.st.com>
Message-ID: <20121115135555.GC25985@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 01:46:29PM +0000, Etienne CARRIERE ST wrote:
> I think we will internally use our hack in l2x0 spin locking to
> prevent collision, based on old arch_spinlock support.

Or just handle the collision in the secure code and make sure you don't
start background operations. If you don't use background operations, you
don't need any locking.

-- 
Catalin
