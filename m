From: yann.morin.1998@free.fr (Yann E. MORIN)
Date: Tue, 16 Jul 2013 11:45:27 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130716093820.GE4402@pd.tnic>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <201307161132.39845.yann.morin.1998@free.fr> <20130716093820.GE4402@pd.tnic>
Message-ID: <201307161145.27810.yann.morin.1998@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Borislav, All,

On Tuesday 16 July 2013 11:38:20 Borislav Petkov wrote:
> On Tue, Jul 16, 2013 at 11:32:39AM +0200, Yann E. MORIN wrote:
> > That does not work in two cases:
> >   - older distros that do not have the tool packaged
> 
> This point is moot - distro kernels are built by the distro people.

It's not about building distro kernels. It's about building the current
kernel on a distro, for example for cross-compilation.

> >   - automatic test-harness that run thousands of randconfig a day
> randconfigs are not guaranteed to build successfully.

Well, mostly agreed. However, there was a request (in this thread) that
using such new tools that are not yet widely available in distros, does
not break randconfig.

This is a *new* requirement.

> > The idea is to be always have a .config that is buildable with the
> > current toolset of the system, especially for esoteric and/or recent
> > tools that are not packaged and/or installed by default by the
> > distros.
> How are you going to tell the user running make <something>config to
> install the missing tools?

As discussed with Florian in this thread, either one of:
  - a warning at check time
  - a comment in Kconfig

which both are easy enough to achieve. As I said earlier in this thread,
I've been using a similar scheme in crosstool-NG (which uses Kconfig as
its configuration infrastructure), and it has been proven effective
over the past feew years.

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +0/33 662376056 | Software  Designer | \ / CAMPAIGN     |   ^                |
| --==< O_o >==-- '------------.-------:  X  AGAINST      |  /e\  There is no  |
| http://ymorin.is-a-geek.org/ | (*_*) | / \ HTML MAIL    |  """  conspiracy.  |
'------------------------------'-------'------------------'--------------------'
