From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Dec 2013 14:33:41 -0800
Subject: [GIT PULL] DaVinci fixes for v3.13-rc3
In-Reply-To: <529FAC81.6090102@ti.com>
References: <529FAC81.6090102@ti.com>
Message-ID: <CAOesGMjRHM2Ycc9_tPJwaAwL_YgJPKqa3o5vaBFreV1pA6_7Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Pulled.

A suggestion for the future, please try to use a patch description
that doesn't require you to motivate why this is needed now. I.e. the
patch description should contain:

What is broken
How/when it broke (SHA or general timeframe)
How it's fixed

In this case, it wasn't obvious what the actual breakage was (i.e.
audio not working), nor when it was introduced.

Of course, if something is trivial you don't need to fill it in, nor
should it be a form-based description. But those three answers should
generally be possible to find in the patch description for a bugfix.


-Olof

On Wed, Dec 4, 2013 at 2:28 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v3.13-rc3
>
> for you to fetch changes up to ee880dbd1688c99084052c7890246c1e16c89820:
>
>   ARM: davinci: Fix McASP mem resource names (2013-12-05 03:02:20 +0530)
>
> ----------------------------------------------------------------
> This pull request includes a patch
> to align platform code to driver's
> usage of platform_get_resource_byname()
>
> This is needed to start successfully probing
> audio again. The regression was introduced
> in v3.13 merge window.
>
> ----------------------------------------------------------------
> Peter Ujfalusi (1):
>       ARM: davinci: Fix McASP mem resource names
>
>  arch/arm/mach-davinci/devices-da8xx.c |    4 ++--
>  arch/arm/mach-davinci/dm355.c         |    1 +
>  arch/arm/mach-davinci/dm365.c         |    1 +
>  arch/arm/mach-davinci/dm644x.c        |    1 +
>  arch/arm/mach-davinci/dm646x.c        |    4 ++--
>  5 files changed, 7 insertions(+), 4 deletions(-)
