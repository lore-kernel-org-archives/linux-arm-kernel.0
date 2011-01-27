From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 18:59:35 +0000
Subject: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
	support for arch < ARMv6K
In-Reply-To: <AANLkTimN8Gn5a-k4ai7EhMGpqbj_u4Y8fHvUh_actzd+@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk>
	<AANLkTimN8Gn5a-k4ai7EhMGpqbj_u4Y8fHvUh_actzd+@mail.gmail.com>
Message-ID: <20110127185935.GA1651@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 06:14:56PM +0000, Catalin Marinas wrote:
> On 17 January 2011 19:24, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Rather than turning off CPU domain switching when the build architecture
> > includes ARMv6K, thereby causing problems for ARMv6-supporting kernels,
> > turn it on when it's required to support a CPU architecture.
> 
> (sorry, I'm well behind list messages, didn't reply earlier)
> 
> Does it mean that we get domains enabled even for ARMv7 when ARMv6 is
> built in the same kernel? The side effect is that user read-only
> addresses are writable by the kernel and SWP emulation no longer
> works.

It means that a kernel with ARMv6 through to ARMv7 will have CPU
domains enabled.  So maybe we want:

config CPU_32v6
	select CPU_USE_DOMAINS if !CPU_V6K && MMU

instead?
