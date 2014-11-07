From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Nov 2014 12:11:19 +0000
Subject: [RFC] ptrace: add generic SET_SYSCALL request
In-Reply-To: <1678531.AUssrM9PAs@wuerfel>
References: <1415346443-28915-1-git-send-email-takahiro.akashi@linaro.org>
 <1977974.l97vvy7Y8b@wuerfel> <20141107115551.GC18916@arm.com>
 <1678531.AUssrM9PAs@wuerfel>
Message-ID: <20141107121119.GQ4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 01:03:00PM +0100, Arnd Bergmann wrote:
> On Friday 07 November 2014 11:55:51 Will Deacon wrote:
> > We need this for arm64 and, since all architectures seem to have a mechanism
> > for setting a system call via ptrace, moving it to generic code should make
> > sense for new architectures too, no?
> 
> It makes a little more sense now, but I still don't understand why you
> need to set the system call number via ptrace. What is this used for,
> and why doesn't any other architecture have this?

All other architectures have a way.  x86, for example, you set orig_eax
(or orig_rax) to change the syscall number.  On ARM, that doesn't work
because we don't always pass the syscall number in a register.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
