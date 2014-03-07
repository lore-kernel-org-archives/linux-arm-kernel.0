From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Mar 2014 15:48:44 +0100
Subject: [PATCH] i2c: mv64xxx: Fix circular dependencies warning and
 compilation breakage
In-Reply-To: <20140307142405.GB28943@katana>
References: <20140307111858.GB12274@katana>
 <1394199795-5516-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140307142405.GB28943@katana>
Message-ID: <20140307144844.GS607@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 03:24:05PM +0100, Wolfram Sang wrote:
> 
> New patch -> new thread, please.
> 
> > This patch fixes the circular dependency introduced by commit 370136bc67c3
> > ("i2c: mv64xxx: Add reset deassert call"):
> > 
> > drivers/video/Kconfig:42:error: recursive dependency detected!
> 
> Please base it on i2c-next. I already applied my patch.
> Your patch fixes the build error discovered by it.

I didn't realise that. I will.

> > Since the reset framework doesn't define dummy stubs whenever
> > CONFIG_RESET_CONTROLLER is not defined, it's the only sane way to have a driver
> > that compiles in any cases.
> 
> Paragraph needs reformat. And please drop "sane". #ifdefs are not sane.
> Fixing the reset framework would be sane.

Ok..

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/c66db7b9/attachment.sig>
