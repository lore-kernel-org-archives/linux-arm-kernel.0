From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 30 Jan 2013 11:00:50 -0500 (EST)
Subject: Commit 384a290283fde63ba8dc671fca5420111cdac19a seems to break
 11MPCore boot
In-Reply-To: <51093B0B.7010708@arm.com>
References: <51093B0B.7010708@arm.com>
Message-ID: <alpine.LFD.2.02.1301301050230.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jan 2013, Punit Agrawal wrote:

> Hi Nicolas,
> 
> I was trying to boot 3.8-rc5 on Realview EB 11MPCore using
> realview-smp_defconfig as a starting point but the kernel failed to progress
> past the log below (config attached).
> 
> Pawel suggested I try reverting 384a290283fde63ba8dc671fca5420111cdac19a -
> "ARM: gic: use a private mapping for CPU target interfaces" that you've
> authored. With this commit reverted the kernel boots.
> 
> I am not quite sure why the commit breaks 11MPCore but Pawel (cc'd) might be
> able to shed light on that.

That would be appreciated as I don't have any good answer to provide.

Typically, this patch highlighted problems with bad holding pen 
implementations where secondary CPUs would enter the kernel all at the 
same time. In that case the kernel was crashing even before displaying 
"CPU2: Booted secondary processor".


Nicolas
