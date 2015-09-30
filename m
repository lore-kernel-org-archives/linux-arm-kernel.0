From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 11:50:27 +0100
Subject: [PATCH v5 05/22] xen/grant: Add helper
 gnttab_page_grant_foreign_access_ref_one
In-Reply-To: <1443609937-25278-6-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
 <1443609937-25278-6-git-send-email-julien.grall@citrix.com>
Message-ID: <560BBE73.3070402@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/15 11:45, Julien Grall wrote:
> Many PV drivers contain the idiom:
> 
> pfn = page_to_gfn(...) /* Or similar */
> gnttab_grant_foreign_access_ref
> 
> Replace it by a new helper. Note that when Linux is using a different
> page granularity than Xen, the helper only gives access to the first 4KB
> grant.
> 
> This is useful where drivers are allocating a full Linux page for each
> grant.
> 
> Also include xen/interface/grant_table.h rather than xen/grant_table.h in
> asm/page.h for x86 to fix a compilation issue [1]. Only the former is
> useful in order to get the structure definition.
> 
> [1] Interdependency between asm/page.h and xen/grant_table.h which result
> to page_mfn not being defined when necessary.
> 
> Signed-off-by: Julien Grall <julien.grall@linaro.org>

Hmmm... this should be julien.grall at citrix.com. Still mixing up with my
old address.

I've fixed it in the branch associated to this series.

Regards,

-- 
Julien Grall
