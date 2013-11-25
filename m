From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 25 Nov 2013 13:55:09 -0800
Subject: [PATCH V3] dma: add channel request API that supports deferred
 probe
In-Reply-To: <1385416039-3170-1-git-send-email-swarren@wwwdotorg.org>
References: <1385416039-3170-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAPcyv4i2s=CZMiggxJ+EgTnXqaKEptykRW0DVycneqPQm9e++A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 1:47 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> dma_request_slave_channel() simply returns NULL whenever DMA channel
> lookup fails. Lookup could fail for two distinct reasons:
>
> a) No DMA specification exists for the channel name.
>    This includes situations where no DMA specifications exist at all, or
>    other general lookup problems.
>
> b) A DMA specification does exist, yet the driver for that channel is not
>    yet registered.
>
> Case (b) should trigger deferred probe in client drivers. However, since
> they have no way to differentiate the two situations, it cannot.
>
> Implement new function dma_request_slave_channel_or_err(), which performs

Oops, one more s/_or_err/_reason/

Other than that:
Acked-by: Dan Williams <dan.j.williams@intel.com>
