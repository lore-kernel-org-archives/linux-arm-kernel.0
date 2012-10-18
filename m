From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Oct 2012 10:53:28 +0100
Subject: [PATCH V2 3/3] ARM: tegra: move debug-macro.S to include/debug
In-Reply-To: <507F1F31.2060503@wwwdotorg.org>
References: <1350328024-30485-1-git-send-email-swarren@wwwdotorg.org>
 <1350328024-30485-3-git-send-email-swarren@wwwdotorg.org>
 <507EC303.1080000@gmail.com> <507EDB37.1060102@wwwdotorg.org>
 <507F1F31.2060503@wwwdotorg.org>
Message-ID: <20121018095328.GS21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 03:12:17PM -0600, Stephen Warren wrote:
> That implies we really do need to keep the two pieces of code completely
> in sync, so a shared header is the right way to go. It also implies that
> having duplicate mappings of the same physical address doesn't cause any
> immediate obvious catastrophic problems.
> 
> Ways we might avoid files in arch/arm/include/debug having to use
> relative include paths to pick up that header are:

Why not take the opposite approach.  Treat the platform as setting up the
addresses for the UART.  Then arrange for the debug macros to match that.
Or we define a common virtual address for debug UARTs (which platforms
would not be able to use).

> b) Rework debug-macro.S so that it isn't an include file, but rather a
> regular top-level file.

No, that won't work.  It's used in two places - the kernel and the
decompressor.  Hence why it is an include file (it's not an include
file just for the fun of it.)
