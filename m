From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 5 Dec 2016 11:05:26 +0800
Subject: [PATCH v2 2/6] mm: hugetlb: add a new parameter for some functions
In-Reply-To: <20161202135229.GJ6830@dhcp22.suse.cz>
References: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
 <1479107259-2011-3-git-send-email-shijie.huang@arm.com>
 <20161202135229.GJ6830@dhcp22.suse.cz>
Message-ID: <20161205030525.GA13365@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 02:52:30PM +0100, Michal Hocko wrote:
> On Mon 14-11-16 15:07:35, Huang Shijie wrote:
> > This patch adds a new parameter, the "no_init", for these functions:
> >    alloc_fresh_gigantic_page_node()
> >    alloc_fresh_gigantic_page()
> > 
> > The prep_new_huge_page() does some initialization for the new page.
> > But sometime, we do not need it to do so, such as in the surplus case
> > in later patch.
> > 
> > With this parameter, the prep_new_huge_page() can be called by needed:
> >    If the "no_init" is false, calls the prep_new_huge_page() in
> >    the alloc_fresh_gigantic_page_node();
> 
> This double negative just makes my head spin. I haven't got to later
> patch to understand the motivation but if anything bool do_prep would
> be much more clear. In general doing these "init if a parameter is
Okay, I will use the "do_prep" for the new parameter.

thanks for the code review.

Huang Shijie
