From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Thu, 12 Jan 2017 09:53:39 -0800
Subject: [PATCH 1/2] memory: aemif: allow passing device lookup table as
 platform data
In-Reply-To: <1483526167-24209-2-git-send-email-bgolaszewski@baylibre.com>
References: <1483526167-24209-1-git-send-email-bgolaszewski@baylibre.com>
 <1483526167-24209-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <6a5f9add-f1be-dade-842a-53afb88bb8db@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/4/17 2:36 AM, Bartosz Golaszewski wrote:
> TI aemif driver creates its own subnodes of the device tree in order
> to guarantee that all child devices are probed after the AEMIF timing
> parameters are configured.
>
> Some devices (e.g. da850) use struct of_dev_auxdata for clock lookup
> but nodes created from within the aemif driver can't access the lookup
> table.
>
> Create a platform data structure that holds a pointer to
> of_dev_auxdata so that we can use it with of_platform_populate().
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
Patch looks fine to me. Did I miss PATCH 2/2 ?
drivers/memory/* patches has been queue via Greg KH tree. Please
repost your series with acks and copy Greg. I will request Greg
to queue these changes via his tree.

Regards,
Santosh
