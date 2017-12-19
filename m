From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 19 Dec 2017 08:49:58 +0000
Subject: [PATCH v6] atmel_flexcom: Support resuming after a chip reset
In-Reply-To: <20171212162119.32138-1-romain.izard.pro@gmail.com>
References: <20171212162119.32138-1-romain.izard.pro@gmail.com>
Message-ID: <20171219084958.fvogrczvrxcwazrx@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Dec 2017, Romain Izard wrote:

> The controller used by a flexcom module is configured at boot, and left
> alone after this. In the suspend mode called "backup with self-refresh"
> available on SAMA5D2, the chip will resume with most of its registers
> reset. In this case, we need to restore the state of the flexcom driver
> on resume.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
> Changes in v5:
> * extract from the patch series, and send as a standalone patch
> 
> Changes in v6:
> * Reword the patch title and description
> * Rename the internal structure to ddata
> 
>  drivers/mfd/atmel-flexcom.c | 63 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 15 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
