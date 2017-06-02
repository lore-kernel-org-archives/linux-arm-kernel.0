From: olof@lixom.net (Olof Johansson)
Date: Thu, 1 Jun 2017 17:17:11 -0700
Subject: [PATCH 0/2] ARCH_VULCAN removal
In-Reply-To: <20170522074102.tjhkx62fmjlb3lzf@pengutronix.de>
References: <1495438565-82495-1-git-send-email-jnair@caviumnetworks.com>
 <20170522074102.tjhkx62fmjlb3lzf@pengutronix.de>
Message-ID: <20170602001711.GI13314@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 09:41:02AM +0200, Uwe Kleine-K?nig wrote:
> On Mon, May 22, 2017 at 07:36:03AM +0000, Jayachandran C wrote:
> > Another couple of patches to remove more of ARCH_VULCAN platform.
> > 
> > There is still a reference in drivers/gpio/Kconfig for ARCH_VULCAN.
> > I am sending a patch to remove that, and after that we can completely
> > remove ARCH_VULCAN.
> 
> What happens if ARCH_VULCAN and drivers/gpio/Kconfig still references
> it? I expected it's just assumed to be 'n' then?

Are you talking about this line?

depends on OF_GPIO && (CPU_XLP || ARCH_VULCAN || ARCH_THUNDER2 || COMPILE_TEST)

It will continue to work as long as you enabel ARCH_THUNDER2, which is the "new
name" for Vulcan.

(Yes, renames like these are really annoying. We normally don't do them but
it's a small one in this case).


-Olof
