From: srinidhi.kasagar@stericsson.com (Srinidhi KASAGAR)
Date: Wed, 16 Feb 2011 10:38:48 +0530
Subject: [PATCH] ARM: errata: pl310 cache sync operation may be faulty
In-Reply-To: <AANLkTikPGwcm-_j-NzW2UixaEx_ekJMjJcrTO1SUy7Ao@mail.gmail.com>
References: <1297768683-30273-1-git-send-email-srinidhi.kasagar@stericsson.com>
	<AANLkTikPGwcm-_j-NzW2UixaEx_ekJMjJcrTO1SUy7Ao@mail.gmail.com>
Message-ID: <20110216050842.GB17274@bnru02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 17:38:52 +0100, Catalin Marinas wrote:
> On 15 February 2011 11:18, srinidhi kasagar
> <srinidhi.kasagar@stericsson.com> wrote:
> > +config ARM_ERRATA_753970
> > + ? ? ? bool "ARM errata: cache sync operation may be faulty"
> > + ? ? ? depends on CACHE_PL310
> > + ? ? ? help
> > + ? ? ? ? This option enables the workaround for the 753970 PL310 erratum.
> 
> Is this number correct? I couldn't find it in ARM's internal database.
yes, we got this errata notice from ARM recently (10-feb-11), document
revision 12.1

> 
> > + ? ? ? ? Under some condition the effect of cache sync operation on
> > + ? ? ? ? the store buffer still remains when the operation completes.
> > + ? ? ? ? This means that the store buffer is always asked to drain and
> > + ? ? ? ? this prevents it from merging any further writes. The workaround
> > + ? ? ? ? is to replace the normal offset of cache sync operation (0x730)
> > + ? ? ? ? by another offset targeting an unmapped PL310 register 0x740.
> > + ? ? ? ? This has the same effect as the cache sync operation: store buffer
> > + ? ? ? ? drain and waiting for all buffers empty.
> 
> You may want to specify the revision number this applies to so that
> people to enable it if not needed.
OK, will include this revision number

srinidhi
