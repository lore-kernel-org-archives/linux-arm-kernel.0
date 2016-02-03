From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Wed, 3 Feb 2016 09:01:59 +0100
Subject: [PATCH 1/5] all: s390: move wrapper infrastructure to generic
 headers
In-Reply-To: <20160202204156.GA27290@yury-N73SV>
References: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
 <1453741047-5498-2-git-send-email-ynorov@caviumnetworks.com>
 <20160128121618.GB5418@osiris> <20160128163109.GA8529@yury-N73SV>
 <20160201114251.GB973@yury-N73SV> <20160202073913.GB3990@osiris>
 <20160202154331.GA3003@yury-N73SV> <20160202160826.GF3990@osiris>
 <20160202195434.GA3397@osiris> <20160202204156.GA27290@yury-N73SV>
Message-ID: <20160203080159.GA3369@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 11:41:56PM +0300, Yury Norov wrote:
> On Tue, Feb 02, 2016 at 08:54:34PM +0100, Heiko Carstens wrote:
> > So I think I can summarize my point to: if you can enforce correctness, why
> > shouldn't you do it if the performance impact is only a single instruction.
> 
> For aarch64 it's 5 instructions. But what's more important (if ever),
> another wrapper takes another i-cache line...
>         <compat_SyS_ftruncate>:
>         stp     x29, x30, [sp,#-16]!
>         mov     x29, sp
>         bl      d40 <do_sys_ftruncate.constprop.3>
>         ldp     x29, x30, [sp],#16
>         ret

Why does gcc allocate a stackframe here? Don't you have tail call
optimization?
