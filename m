From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Dec 2015 17:18:56 +0000
Subject: [RFC2 PATCH v6 00/19] ILP32 for ARM64
In-Reply-To: <20151204153550.GB1251@yury-N73SV>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <20151203175955.GP10747@e104818-lin.cambridge.arm.com>
 <20151204153550.GB1251@yury-N73SV>
Message-ID: <20151204171856.GP10123@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 06:35:50PM +0300, Yury Norov wrote:
> On Thu, Dec 03, 2015 at 05:59:55PM +0000, Catalin Marinas wrote:
> > On Wed, Nov 18, 2015 at 12:16:40AM +0300, Yury Norov wrote:
> > >  - ILP32 VDSO code excluded. It's not mandatory, and caused questions
> > >    during review process. We definitely make sure we will follow up
> > >    with a VDSO later on because it is needed for performance reasons;
> > 
> > I already asked in one of the patches, don't you need a VDSO for
> > sigreturn?
> 
> I didn't realise it's mandatory for ARMv8 when removed it. I'll back
> it, but I think rework required anyway.

The alternative is to use SA_RESTORER but AFAIK, its use has been
deprecated. I don't know what aarch64 glibc does if it doesn't have a
vdso.

-- 
Catalin
