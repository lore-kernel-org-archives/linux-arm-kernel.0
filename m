From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Apr 2012 11:44:52 +0100
Subject: linux-next: "amba: Remove AMBA level regulator support" commit.
In-Reply-To: <20120413103207.GL24211@n2100.arm.linux.org.uk>
References: <20120413012230.GA30438@windriver.com>
 <CAAQ0ZWReL=+bm9UOnt2=Dfy0zeWbJe3=y3pPzUKRzm2y277kFQ@mail.gmail.com>
 <20120413103207.GL24211@n2100.arm.linux.org.uk>
Message-ID: <20120413104452.GR3168@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 11:32:07AM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 13, 2012 at 10:01:52AM +0800, Shawn Guo wrote:

> > That's because Mark's patch removes "#include
> > <linux/regulator/consumer.h>" included indirectly by
> > drivers/dma/ste_dma40.c from linux/amba/bus.h.  The ste_dma40.c should
> > really directly includes consumer.h.

> Okay, I'll drop this patch because it's causing regressions, so it can't
> be pushed as a 'fix' during -rc.

I did say we should've been pushing Shawn's patch in as a minimal fix
for 3.4...  Alternatively if you're happy with the code just keeping the
header in place should avoid any issues, the one regression was just an
implicit header dependency.

Regardless of what happens for 3.4 we should keep the removal for -next,
it's clear that we don't want the bus doing this and it's causing
breakage for the non-ST platforms.  Do I need to resend the patch to the
patch system or will the existing copy be OK?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120413/34135552/attachment.sig>
