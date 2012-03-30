From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Mar 2012 17:34:04 -0700
Subject: [GIT PULL 1/5] ARM: cleanups of io includes
In-Reply-To: <CAOesGMgaQ7mjV-1Q5uPthw8PAtU+BUfDgOqor=3jtvkL30L1ZA@mail.gmail.com>
References: <1332918842-13521-1-git-send-email-olof@lixom.net>
 <1332918842-13521-2-git-send-email-olof@lixom.net>
 <20120328082501.GA22414@n2100.arm.linux.org.uk>
 <CAOesGMjwZOON9kFNvaEq8QhSvjAgsJT_J1Ysb9-AbePd6g+-rQ@mail.gmail.com>
 <20120328192816.GD22414@n2100.arm.linux.org.uk>
 <CA+55aFyJH8yO7=AzuddsQZouHqRDtmeh-vbd8Y5VQLQx-6ZV-Q@mail.gmail.com>
 <CAOesGMgaQ7mjV-1Q5uPthw8PAtU+BUfDgOqor=3jtvkL30L1ZA@mail.gmail.com>
Message-ID: <CAOesGMj4Osx0KBCxM4_N09PMTkpTdhhQRvEcwEeY8PFKanT_-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 5:27 PM, Olof Johansson <olof@lixom.net> wrote:

> It hasn't grown any new merge conflicts
> since before as of now, so see the original pull request for those.

D'oh, I did a git remote update but didn't checkout the new head for
your tree when I verified the merge conflict situation. It does have a
couple of new trivial ones:

* arch/arm/mach-tegra/Makefile: keep reset.o, remove localtimer.o
* arch/arm/mach-vexpress/include/mach/io.h: line remove vs file remove
conflict: file is gone, but a patch in rmk's tree had removed a line
from it. It's safe to still remove the file.

+ the previous ones from original pull request:

arch/arm/Kconfig: New selects added for ARCH_S3C24X. Include both
sides of the merge.

arch/arm/mach-shmobile/smp-sh73a0.c: A readl vs readw fix collided
with the io accessor cleanup. Ditch the __io() use but keep readl.

arch/arm/mach-tegra/include/mach/debug-macro.S: include of mach/io.h
is going away, iomap.h is kept.

-Olof
