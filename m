From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Sep 2016 13:29:21 +0100
Subject: [PATCH 2/2] armv8: aarch32: Add SMP support for 32-bit Linux
 kernel
In-Reply-To: <1474597146-33312-2-git-send-email-b18965@freescale.com>
References: <1474597146-33312-1-git-send-email-b18965@freescale.com>
 <1474597146-33312-2-git-send-email-b18965@freescale.com>
Message-ID: <20160923122921.GD10042@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 10:19:06AM +0800, Alison Wang wrote:
> The patch adds SMP support for running 32-bit Linux kernel for
> Layerscape platforms. Spin-table method is used for SMP support.

So far, spin-table has not been defined for 32-bit, and the code below,
while mostly a copy of the 64-bit code, is somewhat different.

If you want a common enable method, I would strongly advise that you use
PSCI, which is well-defined for both 32-bit and 64-bit. There are a
number of problems with spin-table, and I would not recommend extending
it to 32-bit ARM.

Thanks,
Mark.
