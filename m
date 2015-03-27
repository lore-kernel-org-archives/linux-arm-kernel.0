From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 27 Mar 2015 14:52:41 +0100
Subject: [PATCH] pinctrl: mvebu: add suspend/resume support to Armada XP
 pinctrl driver
In-Reply-To: <CACRpkdZ_2FJLJJaDuqw=9cxxJwacz06KssfSK_HVg2jZ6E-6eQ@mail.gmail.com>
References: <1426761047-3103-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CACRpkdZ_2FJLJJaDuqw=9cxxJwacz06KssfSK_HVg2jZ6E-6eQ@mail.gmail.com>
Message-ID: <20150327145241.688935d3@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Fri, 27 Mar 2015 09:37:19 +0100, Linus Walleij wrote:

> Patch applied, but:
> 
> >  static void __iomem *mpp_base;
> > +static u32 *mpp_saved_regs;
> 
> I didn't notice this singleton design pattern in this driver before :(
> I see the legacy Dove driver have a few more.
> 
> Can we have a mvebu refactoring patch bringing these things into a state
> container? Like a per-subdriver kmalloc:ed struct foo_state {}?

Yes, I agree this isn't nice. I'll try to nice what I can come up with
and propose a patch.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
