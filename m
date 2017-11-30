From: mhocko@kernel.org (Michal Hocko)
Date: Thu, 30 Nov 2017 15:57:34 +0100
Subject: [PATCH v2 0/5] Memory hotplug support for arm64 - complete
 patchset v2
In-Reply-To: <20171123173331.GA15535@samekh>
References: <cover.1511433386.git.ar@linux.vnet.ibm.com>
 <20171123160258.xmw5lxnjfch2dxfw@dhcp22.suse.cz>
 <20171123173331.GA15535@samekh>
Message-ID: <20171130145734.c62ggrx3r7335etc@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 23-11-17 17:33:31, Andrea Reale wrote:
> On Thu 23 Nov 2017, 17:02, Michal Hocko wrote:
> 
> Hi Michal,
> 
> > I will try to have a look but I do not expect to understand any of arm64
> > specific changes so I will focus on the generic code but it would help a
> > _lot_ if the cover letter provided some overview of what has been done
> > from a higher level POV. What are the arch pieces and what is the
> > generic code missing. A quick glance over patches suggests that
> > changelogs for specific patches are modest as well. Could you give us
> > more information please? Reviewing hundreds lines of code without
> > context is a pain.
> 
> sorry for the lack of details. I will try to provide a better
> overview in the following. Please, feel free to ask for more details
> where needed.
> 
> Overall, the goal of the patchset is to implement arch_memory_add and
> arch_memory_remove for arm64, to support the generic memory_hotplug
> framework. 
> 
> Hot add
> -------
> Not so many surprises here. We implement the arch specific
> arch_add_memory, which builds the kernel page tables via hotplug_paging()
> and then calls arch specific add_pages(). We need the arch specific
> add_pages() to implement a trick that makes the satus of pages being
> added accepted by the asumptions made in the generic __add_pages. (See
> code comments).

Actually I would like to see exactly this explained. The arch support of
the hotplug should be basically only about arch_add_memory and add_pages
resp. arch_remove_memory and __remove_pages. Nothing much more, really.
The core hotplug code should take care of the rest. Ideally you
shouldn't be really forced to touch the generic code. If yes than this
should be called out explicitly.
-- 
Michal Hocko
SUSE Labs
