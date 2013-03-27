From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Mar 2013 09:29:45 +0000
Subject: [PATCH v2 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <CAHTX3dJoAW=KPAS4x-==bLY-COxCXPKdtNuEMGZEu-npR5t-hg@mail.gmail.com>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <201303262144.45158.arnd@arndb.de>
 <CAHTX3dJoAW=KPAS4x-==bLY-COxCXPKdtNuEMGZEu-npR5t-hg@mail.gmail.com>
Message-ID: <201303270929.45733.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 March 2013, Michal Simek wrote:
> 2013/3/26 Arnd Bergmann <arnd@arndb.de>:
> > On Tuesday 26 March 2013, Michal Simek wrote:
> >> +void __iomem *scu_base;
> >> +
> >
> > This cannot be a global variable in a multiplatform kernel. Can you
> > make it static?
> 
> This global variable is shared because I am using it in smp code
> and also it will be used in pm code we have.
> 
> What is it another way how to handle this?
> 
> Because the same problem could be with zynq_slcr_base.
> 
> Or the rule is just to use zynq_ prefix for all global variables?
> 

Yes. The best solution is to mke variables local to some context and
only pointed to by other data structures. If that doesn't work, you
should try using a static variable in one file and move all code using
it there. If that doesn't work, you need a global variable, but that
must be uniquely named.

	Arnd
