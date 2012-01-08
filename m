From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Jan 2012 16:14:01 +0000
Subject: [RFC PATCH v2 8/9] smp: refactor on_each_cpu to void returning
 func
In-Reply-To: <1326029549-2794-9-git-send-email-gilad@benyossef.com>
References: <1326029549-2794-1-git-send-email-gilad@benyossef.com>
 <1326029549-2794-9-git-send-email-gilad@benyossef.com>
Message-ID: <20120108161401.GE21765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 03:32:28PM +0200, Gilad Ben-Yossef wrote:
> on_each_cpu returns the retunr value of smp_call_function
> which is hard coded to 0.
> 
> Refactor on_each_cpu to a void function and the few callers
> that check the return value to save compares and branches.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Reviewed-by: Michal Nazarewicz <mina86@mina86.com>
> CC: David Airlie <airlied@linux.ie>
> CC: dri-devel at lists.freedesktop.org
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Grant Likely <grant.likely@secretlab.ca>
> CC: Rob Herring <rob.herring@calxeda.com>
> CC: linuxppc-dev at lists.ozlabs.org
> CC: devicetree-discuss at lists.ozlabs.org
> CC: Richard Henderson <rth@twiddle.net>
> CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> CC: Matt Turner <mattst88@gmail.com>
> CC: linux-alpha at vger.kernel.org
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: x86 at kernel.org
> CC: Tony Luck <tony.luck@intel.com>
> CC: Fenghua Yu <fenghua.yu@intel.com>
> CC: linux-ia64 at vger.kernel.org
> CC: Will Deacon <will.deacon@arm.com>
> CC: Peter Zijlstra <a.p.zijlstra@chello.nl>
> CC: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
> CC: Russell King <linux@arm.linux.org.uk>

As there's only one place in the ARM code where we look at the return
value, and you've patched that away in patch 1, this looks fine.  I've
not checked for users outside of arch/arm, so:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.
