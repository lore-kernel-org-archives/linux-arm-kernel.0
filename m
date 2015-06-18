From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 18 Jun 2015 12:04:16 +0300
Subject: [PATCH v5 1/4] remoteproc: introduce rproc_get_by_phandle API
In-Reply-To: <1434566762-40702-1-git-send-email-d-gerlach@ti.com>
References: <1432327530-48032-2-git-send-email-d-gerlach@ti.com>
 <1434566762-40702-1-git-send-email-d-gerlach@ti.com>
Message-ID: <CAK=Wgbb1e6O574Bpicy4Y623vtiigauT22H-zk+JXGCz070i5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Wed, Jun 17, 2015 at 9:46 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Allow users of remoteproc the ability to get a handle to an rproc by
> passing a phandle supplied in the user's device tree node. This is
> useful in situations that require manual booting of the rproc.
>
> This patch uses the code removed by commit 40e575b1d0b3 ("remoteproc:
> remove the get_by_name/put API") for the ref counting but is modified
> to use a simple list and locking mechanism and has rproc_get_by_name
> replaced with an rproc_get_by_phandle API.
>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v4->v5: Fixed build error from of_find_node_by_phandle when !CONFIG_OF
>         based on offline discussion.

We can't rebase our for-next branch, so I've applied a
similar fix in a separate patch.

Please check our for-next branch to make sure things still work for you.

Thanks,
Ohad.
