From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 15 Jan 2015 12:13:34 +0200
Subject: [PATCH v7 0/4] hwspinlock core & omap dt support
In-Reply-To: <1421269101-51105-1-git-send-email-s-anna@ti.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
Message-ID: <CAK=Wgba1S58OMs=FTfv=UraU_3EZn_eOLmADtCjrvJkDSGw8WA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Wed, Jan 14, 2015 at 10:58 PM, Suman Anna <s-anna@ti.com> wrote:
> This is an updated version of the hwspinlock dt support series,
> rebased onto v3.19-rc3 and mainly addresses the continued discussion
> on the need to maintain a list of registered spinlock banks [1].
> I have removed this patch as per your wish, and as a result the
> burden of the spinlock validation and deferred probing is pushed
> onto the hwspinlock clients. Sorry for the delay in refreshing this
> series, hopefully this can be the last revision.
>
> Following are the main changes in v7 w.r.t v6:
> - Dropped the patch "hwspinlock/core: maintain a list of registered
>   hwspinlock banks"
> - Updated generic hwspinlock bindings to make hwlock-base-id property
>   mandatory.
> - Updated the OMAP hwspinlock binding and DT support patches to correct
>   for the mandatory hwlock-base-id property.
> - Updated the common OF helpers patch to move the of_hwspin_lock_get_base_id()
>   and of_hwspin_lock_get_num_locks() functions into the internal header,
>   these are no longer exported, but available for platform implementations.
>   of_hwspin_lock_get_id() is also simplified now.

This looks good, thanks.

Please try to get an ACK from a DT maintainer on the first two dt
patches, and then I can take the patches to Linus.

Thanks,
Ohad.
