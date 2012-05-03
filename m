From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 May 2012 23:51:05 +0100
Subject: [PATCH] ARM: Enable I$/D$/BrPredict based on config
In-Reply-To: <1336078825-9810-1-git-send-email-bryan.buckley@ti.com>
References: <1336078825-9810-1-git-send-email-bryan.buckley@ti.com>
Message-ID: <20120503225105.GH897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 04:00:25PM -0500, Bryan Buckley wrote:
> Currently we only disable these bits based on config. Now we will
> use this config option to explicitly enable these features at this
> point regardless of what bootloader, other SW, or HW did before.

NAK.  r0 comes from the CPU specific file.  It is up to the CPU
specific support file to decide what setting is appropriate.  For
example, a CPU not implementing the I bit will require this bit to
be preserved, rather than being explicitly written as one or zero.

The ifdefs here are just disable-overrides for that, primerily to allow
testing of new CPUs.
