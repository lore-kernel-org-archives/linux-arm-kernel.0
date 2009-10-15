From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Thu, 15 Oct 2009 13:52:41 +0200
Subject: arm / kirkwood (openrd): cpu_idle
Message-ID: <200910151352.41991.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

we've discussed some days ago the cpu_idle issue on marvell kirkwood devices.
I got following output sometimes. I don't know if this is really a problem?

------------[ cut here ]------------
WARNING: at arch/arm/kernel/process.c:171 cpu_idle+0x74/0xbc()
Modules linked in:
[<c002b8bc>] (unwind_backtrace+0x0/0xd8) from [<c003af1c>] (warn_slowpath_common+0x4c/0x68)
[<c003af1c>] (warn_slowpath_common+0x4c/0x68) from [<c00278c4>] (cpu_idle+0x74/0xbc)
[<c00278c4>] (cpu_idle+0x74/0xbc) from [<c0008b2c>] (start_kernel+0x22c/0x27c)
[<c0008b2c>] (start_kernel+0x22c/0x27c) from [<00008034>] (0x8034)
---[ end trace 134046cd7af57c60 ]---

I've tried to apply the patch Simon mentioned at
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/001624.html
http://patchwork.kernel.org/patch/40871/

But it looks like that in rc4 something has changed so the patch didn't apply without errors.
And I don't know enough about this stuff to know what I'm doing :(

Any help would be appreciated!
Thanks in advance,
Dieter
