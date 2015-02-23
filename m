From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Feb 2015 12:14:37 +0000
Subject: stand-alone kvmtool
In-Reply-To: <54E5C16D.3060109@oracle.com>
References: <54DDD465.3050300@arm.com>
 <54E5C16D.3060109@oracle.com>
Message-ID: <20150223121437.GO8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 05:56:45AM -0500, Sasha Levin wrote:
> What inconvenience is caused by having it sit inside the kernel tree
> beyond an increased requirement in disk space?

I've come across this problem with the perf tools - luckily, the perf
tools allow the source to be exported from the kernel tree, but it is
far from a good solution.

The problem is when you're primarily cross-building the kernel on a
system where you don't have the target libraries (because, eg, you're
running in a build environment for multiple different target systems.)
Having to build userspace tools in that scenario is a _major_ pita.

Yes, of course it's possible to pull the 1GB of kernel GIT respository
down onto the target just to build some silly userspace tool, but when
your rootfs lives on an 8GB SD card or a USB memory stick (as is the
case with the ARM Juno 64-bit platform), and when the userspace tool
somehow depends on the kernel source tree being configured, it really
starts getting painful.

TBH, I don't much care provided there is a way to export a source
tarball for the tool from the kernel (like perf does) which can then
be transferred to the target and built there.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
