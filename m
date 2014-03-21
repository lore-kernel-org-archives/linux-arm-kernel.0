From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 21 Mar 2014 11:14:57 +0800
Subject: [PATCH 0/2] ARM: berlin: SMP support
In-Reply-To: <1395347986-30203-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1395347986-30203-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140321111457.6bed5091@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Mar 2014 13:39:44 -0700
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> This is a small patch set for SMP support on Marvell Berlin BG2
> and recently provided BG2Q. Nothing spectacular, as it basically
> copies SMP holding pen mechanism from mach-prima2 and plat-versatile
> with minor Berlin specific code for SCU and general purpose registers
> used by secondary CPUs to get their boot address.
> 
> There was some IRC discussion with Alexandre about using
> scu_get_base() instead of a DT node. Although BG2Q is true A9
> and provides SCU base; BG2 with PJ4b does not and I decided to
> depend on a DT node for SCU in both cases, which is fine I guess.
> 
> I tested this on BG2, and BG2CD (which is UP). I expect the
> Free-Electrons guys to test on BG2Q.

Although BG2Q and future SoCs will go through PSCI code path finally. But
currently, it's OK to use the pen mechanism.

So for both of these two patches, 

Acked-by: Jisheng Zhang <jszhang@marvell.com>

Thanks,
Jisheng
