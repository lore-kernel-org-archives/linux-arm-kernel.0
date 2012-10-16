From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Oct 2012 22:47:52 +0100
Subject: [RFC PATCH] ARM: kernel: update cpuinfo to print all online
 CPUs features
In-Reply-To: <507DA08B.502@ti.com>
References: <1350404684-6883-1-git-send-email-lorenzo.pieralisi@arm.com>
 <507DA08B.502@ti.com>
Message-ID: <20121016214752.GH21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 11:29:39PM +0530, Santosh Shilimkar wrote:
> Not exactly related to the $subject patch, but I remember doing a patch
> to have cat /proc/cpuinfo spitting only online CPUs just like x86 using
> for_each_online_cpu(i).
> At that point Russell mentioned about a possibility of read() syscall
> spreading over the hot-plug operation and hence the above may not
> be safe.
>
> is that right Russell ?

That is correct, but you will notice that the code now uses the online
cpus rather than the present, inspite of my objections.  I gave up
fighting the case, so now people get to live with the consequences of
this.

This will be fun with dynamic hotplugging with big.LITTLE when people
come to read any of these files which change their output with the
online CPUs.  Oh what fun we're in for there.

I guess the only way to convince people is to let them make their
mistakes in the kernel.
