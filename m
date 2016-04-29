From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 29 Apr 2016 19:08:55 +0300
Subject: [PATCH 25/25] arm64:ilp32: add ARM64_ILP32 to Kconfig
In-Reply-To: <20160429160334.GD30316@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-26-git-send-email-ynorov@caviumnetworks.com>
 <20160429160334.GD30316@e104818-lin.cambridge.arm.com>
Message-ID: <20160429160855.GA16451@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 05:03:34PM +0100, Catalin Marinas wrote:
> On Wed, Apr 06, 2016 at 01:08:47AM +0300, Yury Norov wrote:
> > +config ARM64_ILP32
> > +	bool "Kernel support for ILP32"
> > +	select COMPAT_WRAPPER
> > +	help
> > +	  This option enables support for AArch64 ILP32 user space.  ILP32
> > +	  is an ABI where long and pointers are 32bits but it uses the AARCH64
> > +	  instruction set.
> 
> Is there any penalty for AArch32 tasks when selecting COMPAT_WRAPPER?
> 
> -- 
> Catalin

No. AARCH32 doesn't define __SC_WRAP and so __SYSCALL macro is used,
which fills syscall table with sys_xxx versions, not compat_sys_xxx.
