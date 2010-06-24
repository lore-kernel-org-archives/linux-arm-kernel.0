From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Thu, 24 Jun 2010 11:19:15 +0300
Subject: [PATCH 3/3] add ARM crashdump support
In-Reply-To: <20100624163356.dbb849bc.igawa@mxs.nes.nec.co.jp>
References: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
	<b567a76e7f4502ccd56f818ebd3d6509ebd4a96d.1277188128.git.ext-mika.1.westerberg@nokia.com>
	<20100624163356.dbb849bc.igawa@mxs.nes.nec.co.jp>
Message-ID: <20100624081915.GF29920@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 24, 2010 at 09:33:56AM +0200, ext Masayuki Igawa wrote:
> Hi, Mika.

(...)

> > +unsigned long long
> > +vaddr_to_paddr_arm(unsigned long vaddr)
> > +{
> > +	unsigned long long paddr;
> > +
> > +	if ((paddr = vaddr_to_paddr_general(vaddr)) != NOT_PADDR)
> > +		return paddr;
> 
> Here is a checkpatche.pl's error.
> ====
> ERROR: do not use assignment in if condition
> #303: FILE: arm.c:189:
> +       if ((paddr = vaddr_to_paddr_general(vaddr)) != NOT_PADDR)
> 
> total: 1 errors, 0 warnings, 261 lines checked
> ====

Ah, didn't notice that. Thanks.

> How about is this?
> ====
> +unsigned long long
> +vaddr_to_paddr_arm(unsigned long vaddr)
> +{
> +	unsigned long long paddr = vaddr_to_paddr_general(vaddr);
> +
> +	if (paddr != NOT_PADDR)
> +		return paddr;
> ====

Yeah, looks OK to me.

Do you want me to send a revisited version of the patches or do you change that
yourself?

> BTW, I'm testing these patches for x86/x86_64 arch now.
> I'll merge these patches after my testing.

Cool, thanks.

> But I cannot test for ARM because have no test machines of ARM.

Well I can do the testing for ARM (unless someone else, who is using ARM kdump
currently, wants to test this). If the above is the only change it should still
work.

Thanks,
MW
