From: gerg@snapgear.com (Greg Ungerer)
Date: Wed, 22 Feb 2012 11:33:09 +1000
Subject: [PATCH] ARM: ptrace: fix ptrace_read_user for !CONFIG_MMU
 platforms
In-Reply-To: <20120221101052.GH22562@n2100.arm.linux.org.uk>
References: <1329763029-18220-1-git-send-email-will.deacon@arm.com>
 <20120220194634.GK26840@n2100.arm.linux.org.uk>
 <201202210124.23028.paul@codesourcery.com>
 <20120221083612.GG22562@n2100.arm.linux.org.uk>
 <20120221100041.GA19696@mudshark.cambridge.arm.com>
 <20120221101052.GH22562@n2100.arm.linux.org.uk>
Message-ID: <4F4445D5.9030306@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/12 20:10, Russell King - ARM Linux wrote:
> On Tue, Feb 21, 2012 at 10:00:41AM +0000, Will Deacon wrote:
>> On Tue, Feb 21, 2012 at 08:36:12AM +0000, Russell King - ARM Linux wrote:
>>> Maybe no one uses a debugger for uclinux programs?
>>
>> I confess to finding this by inspection rather than a debugging failure.
>
> There is another explanation - that is no one in the uclinux world uses
> mainline kernels, and this bug has been fixed ages ago in some uclinux
> kernel tree.

There is no separate uclinux kernels or separate patch sets, hasn't been
for a long time. No need, it is all in mainline. There are however plenty
of vendors and individuals using non-MMU platforms who do not push back
to mainline.


> That directly raises the question of the value of having the uclinux
> baggage in the mainline kernel if no one is using mainline kernels for
> uclinux work.  If the uclinux folk aren't willing to pass up bug fixes,
> then having it in mainline is, frankly, a waste of space.

What has historically been called uclinux includes quite a number
of architectures. The problem in this thread is quite clearly ARM
specific. I guess noone using non-MMU Linux on ARM uses gdb to debug.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
