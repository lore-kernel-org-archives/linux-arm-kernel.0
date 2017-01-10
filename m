From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 10 Jan 2017 16:52:40 +0530
Subject: [PATCH 1/2] memory: aemif: allow passing device lookup table as
 platform data
In-Reply-To: <1483526167-24209-2-git-send-email-bgolaszewski@baylibre.com>
References: <1483526167-24209-1-git-send-email-bgolaszewski@baylibre.com>
 <1483526167-24209-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <9f1ad8ee-f745-c191-3340-5fbbca416293@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 January 2017 04:06 PM, Bartosz Golaszewski wrote:
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

I did not really see any precedent to passing of_dev_auxdata as platform
data, but the idea looks fine to me, so:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
