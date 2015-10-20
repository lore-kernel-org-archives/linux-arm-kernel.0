From: geoff@infradead.org (Geoff Levand)
Date: Tue, 20 Oct 2015 10:19:25 -0700
Subject: [PATCH 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <20151020085620.GC31893@dhcppc13.redhat.com>
References: <cover.1445297709.git.geoff@infradead.org>
 <a1c2a702f127d9dade1f9af8ab13decb2ef1c0da.1445297709.git.geoff@infradead.org>
 <20151020085620.GC31893@dhcppc13.redhat.com>
Message-ID: <1445361565.30908.68.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2015-10-20 at 14:26 +0530, Pratyush Anand wrote:
> On 19/10/2015:11:38:53 PM, Geoff Levand wrote:
> > +static void soft_restart(unsigned long addr)
> > +{
> > +> > 	> > setup_mm_for_reboot();
> > +> > 	> > cpu_soft_restart(virt_to_phys(cpu_reset), addr,
> > +> > 	> > 	> > is_hyp_mode_available());
> 
> So now we do not flush cache for any memory region. Shouldn't we still flush
> at least kernel and purgatory segments. 

Relevant pages of the kexec list are flushed in the code following the comment
'Invalidate dest page to PoC' of the arm64_relocate_new_kernel routine:

 The dcache is turned off
 The page is invalidated to PoC
 The new page is written

-Geoff
