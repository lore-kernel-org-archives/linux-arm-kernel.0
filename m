From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Nov 2017 16:48:14 +0100
Subject: [GIT PULL 1/2] omap defconfig changes for v4.15 merge window
In-Reply-To: <pull-1509381562-551838@atomide.com>
References: <pull-1509381562-551838@atomide.com>
Message-ID: <CAK8P3a26fgpZ1BympPxC+cJX6nUm+PYfbDPTEh_onvgf0=UTMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ----------------------------------------------------------------
> Few omap2plus_defconfig changes for v4.15 merge window to enable NEON
> based crypto and droid 4 USB PHY. Also let's run savedefconfig again
> to save a bit of space and make it easier for people to send patches
> against omap2plus_defconfig.

I'm not too fond of the blind 'rerun savedefconfig' patches. Can you respin that
branch and separate that one into at least two patches doing:

- one trivial patch to move the config options that have not changed but only
  appear in a different line

- one patch that drops the other options and has an explanation for each one
  why it's not there any more. Split this up further if necessary.

I mainly want to be sure when we do this that we have not accidentally
dropped an option that got renamed but is actually required for some users.

      Arnd
