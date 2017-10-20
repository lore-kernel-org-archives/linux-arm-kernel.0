From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 20 Oct 2017 14:25:11 -0700
Subject: [PATCH v2 3/3] tty: serial: imx: remove imx_disable_rx_int
In-Reply-To: <20171020212021.13065-3-troy.kisky@boundarydevices.com>
References: <20171020212021.13065-1-troy.kisky@boundarydevices.com>
 <20171020212021.13065-3-troy.kisky@boundarydevices.com>
Message-ID: <15ff545c-5aaf-4f03-3672-2c1702f78316@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2017 2:20 PM, Troy Kisky wrote:
> Since imx_disable_rx_int is only called by imx_startup,
> let's integrate it into that function.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
> v2: new patch
> ---
>  drivers/tty/serial/imx.c | 39 ++++++++++-----------------------------
>  1 file changed, 10 insertions(+), 29 deletions(-)

While testing this series, I noticed that sending a break on the serial port caused

imx-uart 2020000.serial: DMA transaction error.

Is that normal ?
