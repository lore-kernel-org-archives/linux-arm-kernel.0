From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Mar 2014 14:47:39 +0100
Subject: [PATCH 61/62] ARM: sunxi: fix build for THUMB2_KERNEL
In-Reply-To: <6006528.k1jnepzDNv@wuerfel>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <CAL_JsqL_XkF6VRAJdgRmZvX6uud3S8OqvzoTqc9hy2PNDUv5kw@mail.gmail.com>
 <4626847.CFbp3XOTnf@wuerfel> <6006528.k1jnepzDNv@wuerfel>
Message-ID: <20140324134739.GF5416@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 05:24:21PM +0100, Arnd Bergmann wrote:
> On Friday 21 March 2014 17:05:09 Arnd Bergmann wrote:
> > On Friday 21 March 2014 10:54:49 Rob Herring wrote:
> > > The first things secondary_startup do are:
> > > 
> > > -set BE mode
> > > -if in HYP mode, install hyp vectors and drop to SVC
> > > -set the CPSR to a know value (safe_svcmode_maskall r9)
> > > 
> > > So this code is completely redundant and unnecessary. If there were
> > > some reason for it, then it should be in secondary_startup.
> > 
> > Ah, thanks for the clarification. Shall we just delete the file then
> > and jump straight to secondary_startup?
> 
> Maxime, can you test the new version?
> 
> From 2f6220cee15e45446c43e5c43affa85a6c407b31 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Sun, 16 Mar 2014 18:04:54 +0100
> Subject: [PATCH] ARM: sunxi: fix build for THUMB2_KERNEL
> 
> Building an SMP kernel for the sunxi platform with THUMB2 instructions
> fails with this error at the moment:
> 
> headsmp.S:7: Error: Thumb encoding does not support an immediate here -- `msr cpsr_fsxc,#0xd3'
> 
> Since the generic secondary_startup function already does
> the same thing in a safe way, we can just drop the private
> sunxi implementation and jump straight to secondary_startup.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>

With the additional changes you mentionned later that unbreaks the
compilation, you have my acked-by.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/92693cd9/attachment-0001.sig>
