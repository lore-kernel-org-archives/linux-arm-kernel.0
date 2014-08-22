From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Aug 2014 14:33:16 +0100
Subject: [PATCH v3] arm/smp: Absorb boot_secondary()
In-Reply-To: <CAMuHMdVp3xeJ2nDYJ00tLc7HuZ5v+jC-T8omWV5+G_3C8XoyoA@mail.gmail.com>
References: <1404918119-3676-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdXp0ruZjjJLXmWyCdfAXs9_9xFHDcmJ08M9_SbZqqq04g@mail.gmail.com>
 <201408202130.28389.arnd@arndb.de>
 <CAMuHMdVp3xeJ2nDYJ00tLc7HuZ5v+jC-T8omWV5+G_3C8XoyoA@mail.gmail.com>
Message-ID: <20140822133315.GC20583@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 08:55:33PM +0100, Geert Uytterhoeven wrote:
> Has anyone already written a "git-send-email"-compatible script to
> submit patches there?

You can send patches as usual to patches at arm.linux.org.uk, just add
KernelVersion: v3.?? after the --- line in your patch (maybe this could
be automate as well but I didn't bother).

For series, because the arrival order is not guaranteed, I use the git
alias below to trick it into sleeping 60s between patches:

ksend-rmk-patch = !git send-email --annotate --no-thread --suppress-cc=all --to-cmd='sleep 60 && echo patches at arm.linux.org.uk "#"'

For stgit, I have a dedicated template:

From: %(sender)s
To: patches at arm.linux.org.uk
Subject: %(prefix)s%(shortdescr)s

%(longdescr)s
PATCH FOLLOWS
KernelVersion:%(version)s
%(diff)s

And there is always git pull request that Russell is happy with.

-- 
Catalin
