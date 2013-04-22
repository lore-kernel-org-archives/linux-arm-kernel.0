From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Apr 2013 15:07:11 +0100
Subject: [PATCH] ARM: make cpu_init() notrace
In-Reply-To: <1366302046.3388.8.camel@linaro1.home>
References: <1366302046.3388.8.camel@linaro1.home>
Message-ID: <20130422140711.GI14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 05:20:46PM +0100, Jon Medhurst (Tixy) wrote:
> On resume from CPU power down any trace hooks enabled in cpu_init()
> will get called before that function has done set_my_cpu_offset(),
> so any use of per-cpu variables by trace hook code will cause bad
> things to happen. Prevent this by marking the function notrace.
> 
> This fixes lockups/crashes seen when enabling function tracer on TC2
> with the not yet mainlined cpuidle driver.

Looks sane.  Needs to go to the patch system though.  Not sure if it'll
make 3.9 given its proximity (we're on -rc8).
