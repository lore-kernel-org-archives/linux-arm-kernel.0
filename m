From: ccross@google.com (Colin Cross)
Date: Fri, 16 Sep 2011 19:53:52 -0700
Subject: [PATCH 3/3] ARM: vfp: fix a hole in VFP thread migration
In-Reply-To: <E1QfaTD-0006QO-SR@rmk-PC.arm.linux.org.uk>
References: <20110709163207.GN4812@n2100.arm.linux.org.uk>
	<E1QfaTD-0006QO-SR@rmk-PC.arm.linux.org.uk>
Message-ID: <CAMbhsRQSR+ZqF2CHo_pywNyqLU+uVAGDS1PjCAq5ugtE4q7zPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 9, 2011 at 9:33 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Fix a hole in the VFP thread migration. ?Lets define two threads.

I was using the 4 patches in this series on a heavily modified
OMAP4460 SMP kernel based on v3.0, and getting reports from userspace
developers that they were seeing reproducible FP register corruption
resulting in an infinite loop in userspace.  Bisecting this series
showed this patch was the culprit, and reverting this patch and the
following patch fixed the problem.  Since I'm not running a mainline
kernel, this is mostly just an FYI in case someone else sees a similar
problem.
