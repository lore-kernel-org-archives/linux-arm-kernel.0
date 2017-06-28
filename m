From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Wed, 28 Jun 2017 18:24:23 +0200
Subject: [PATCH] arm64: fix missing __user in compat_vfp_{get,set}()
In-Reply-To: <20170628152221.GN8543@e103592.cambridge.arm.com>
References: <20170628145816.24807-1-luc.vanoostenryck@gmail.com>
 <20170628152221.GN8543@e103592.cambridge.arm.com>
Message-ID: <20170628162422.hoayxw3cvc2x63oc@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 04:22:22PM +0100, Dave Martin wrote:
> (There remains a sparse warning in compat_ptrace_write_user(), where we
> pass implicitly cast __user onto a pointer, under set_fs(KERNEL_DS).
> I'm not sure what the most correct fix is there.)

Yes, I saw.
There is no pretty solution for things like here:
you can't adjust the type, you're forced to make a cast,
explicit or implicit.


Regards,
-- Luc
