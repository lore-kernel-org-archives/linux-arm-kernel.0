From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Jul 2015 16:14:47 +0100
Subject: [PATCH 0/2] arm64: support initrd outside of mapped RAM
In-Reply-To: <1438096069.14248.13.camel@redhat.com>
References: <1438093961-15536-1-git-send-email-msalter@redhat.com>
 <20150728145906.GE15213@leverpostej>
 <1438096069.14248.13.camel@redhat.com>
Message-ID: <20150728151447.GF15213@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > >  arch/arm64/kernel/setup.c           | 55 
> > > +++++++++++++++++++++++++++++++++++++
> > >  include/asm-generic/early_ioremap.h |  6 ++++
> > >  mm/early_ioremap.c                  | 22 +++++++++++++++
> > >  3 files changed, 83 insertions(+)
> > 
> > Any reason for not moving x86 over to the new generic version?
> 
> I have a patch to do that but I'm not sure how to contrive a
> testcase to exercise it.

The easiest option might be to hack up KVM tool [1] to load a kernel an
initrd at suitable addresses.

Otherwise I'm sure someone else must have a way of exercising this.

Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/will/kvmtool.git/
