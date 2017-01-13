From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Fri, 13 Jan 2017 08:36:29 -0800
Subject: [PATCH RESEND 1/2] memory: aemif: allow passing device lookup
 table as platform data
In-Reply-To: <1484301626-30345-2-git-send-email-bgolaszewski@baylibre.com>
References: <1484301626-30345-1-git-send-email-bgolaszewski@baylibre.com>
 <1484301626-30345-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <95240fc2-c4d7-1cd8-64b8-6e3b89b9a2e2@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 1/13/2017 2:00 AM, Bartosz Golaszewski wrote:
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
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
> ---
Can you please take this one patch via your driver core ?

Regards,
Santosh
