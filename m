From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Feb 2013 21:58:50 +0000
Subject: [RFC/PATCH 2/5] kernel_cpustat: convert to atomic 64-bit accessors
In-Reply-To: <CAFTL4hw1=mKtUadL0WDrydtspOehKuW7jhhzr65vXR2P2zdTWw@mail.gmail.com>
References: <1361389302-11968-1-git-send-email-khilman@linaro.org>
 <1361389302-11968-3-git-send-email-khilman@linaro.org>
 <87y5ehmp8d.fsf@linaro.org>
 <CAFTL4hw1=mKtUadL0WDrydtspOehKuW7jhhzr65vXR2P2zdTWw@mail.gmail.com>
Message-ID: <20130221215850.GC17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 10:53:07PM +0100, Frederic Weisbecker wrote:
> That too should be kcpustat_this_cpu_set(), or kcpustat_this_cpu_add()
> FWIW. But we probably don't need the overhead of atomic_add() that
> does a LOCK.
> atomic_set(var, atomic_read(var) + delta) would be better. All we need

You mean atomic64_set() and atomic64_read().  Looking at the generic
version in lib/atomic64.c, atomic64_add() is cheaper for 32-bit arches
because it doesn't involve taking the lock twice.
