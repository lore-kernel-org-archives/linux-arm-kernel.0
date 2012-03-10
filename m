From: olof@lixom.net (Olof Johansson)
Date: Sat, 10 Mar 2012 09:45:08 -0800
Subject: [GIT PULL] Samsung board stuff for v3.4
In-Reply-To: <4F5B748B.6050404@samsung.com>
References: <4F5B748B.6050404@samsung.com>
Message-ID: <CAOesGMjiYDFhkjS=2e+3YdPJHExupt3Wm_NS3x1XW-17eEZM=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Mar 10, 2012 at 7:34 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Hi Arnd, Olof,
>
> Please pull regarding Samsung board patches for v3.4.
>
> Most are enabling some features(IPs) on each board and
> one is adding new board file, Samsung Mobile's TRATS board.

Given that exynos has started conversion to device tree, there should
not be any  additions of non-devicetree-probed board files being
added.

At the very least, you should move over to using DT_MACHINE instead of
MACHINE for the new board, and probe using device tree. Even better
would be if you added support for this board through mach-exynos4-dt.c
instead of adding a brand new board file.

I also see a large number of the same additions of devices, done to a
number of board files. I don't think you need to rework those patches
now, but please consider how you can make it less "churny" to add a
device on the SoC in the future without touching all board files.


If you rebase without the board file addition I can take the rest of
the branch while that part is being reworked. Please send a new pull
request with the rebased tree.


Thanks,

-Olof
