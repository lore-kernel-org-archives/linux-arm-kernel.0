From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 16 Jul 2015 17:12:51 +0100
Subject: [Xen-devel] [PATCH v2 04/20] xen/grant: Add helper
 gnttab_page_grant_foreign_access_ref
In-Reply-To: <alpine.DEB.2.02.1507161603490.17378@kaball.uk.xensource.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-5-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1507161603490.17378@kaball.uk.xensource.com>
Message-ID: <55A7D803.4070308@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 16/07/2015 16:05, Stefano Stabellini wrote:
> I like this. I think it might make sense to call it
> gnttab_page_grant_foreign_access_ref_one to make clear that it is only
> granting the first 4K.

Will do.

> In the future we could introduce a new function, called
> gnttab_page_grant_foreign_access_ref, that grants all 4K in the page.

Unless having a different prototype it won't be possible to do it. This 
is because one ref = one grant. We would need a list of grant.

> In any case
>
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Thank you,

-- 
Julien Grall
