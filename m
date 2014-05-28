From: cengelma@gmx.at (Christian Engelmayer)
Date: Wed, 28 May 2014 23:46:06 +0200
Subject: [PATCH] ARM: psci: fix warning on psci_init if ARM_PSCI is
 undefined
In-Reply-To: <20140528075925.GF16428@lvm>
References: <1401225647-8299-1-git-send-email-cengelma@gmx.at>
 <20140528075925.GF16428@lvm>
Message-ID: <20140528234606.47a9bdd2@spike>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 May 2014 09:59:25 +0200, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Tue, May 27, 2014 at 11:20:47PM +0200, Christian Engelmayer wrote:
> > Commit e71246a (PSCI: Add initial support for PSCIv0.2 functions) changed the
> > return type of function psci_init() from void to int, but left the static
> > inline stub used if CONFIG_ARM_PSCI is not defined otherwise untouched. This
> > results in minor compile warning "warning: no return statement in function
> > returning non-void [-Wreturn-type]". The return value is currently not
> > evaluated by the only caller anyway.
> > 
> > Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
> > ---
> > Compile tested only. Applies against branch next in tree
> > git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git
> 
> I sent out a fix for this yesterday as well, think Paolo was going to
> apply that one:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/260009.html

Thanks for letting me know Christoffer! I missed that when checking for already
submitted patches for this. Both patches only differ in the commit log message,
so it's fine either way.

Regards,
Christian
