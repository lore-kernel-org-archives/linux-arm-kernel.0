From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 22 Oct 2017 20:49:56 +0200
Subject: [PATCH v2 3/3] tty: serial: imx: remove imx_disable_rx_int
In-Reply-To: <15ff545c-5aaf-4f03-3672-2c1702f78316@boundarydevices.com>
References: <20171020212021.13065-1-troy.kisky@boundarydevices.com>
 <20171020212021.13065-3-troy.kisky@boundarydevices.com>
 <15ff545c-5aaf-4f03-3672-2c1702f78316@boundarydevices.com>
Message-ID: <20171022184956.exmjlpcbzkvlp7xg@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Oct 20, 2017 at 02:25:11PM -0700, Troy Kisky wrote:
> On 10/20/2017 2:20 PM, Troy Kisky wrote:
> > Since imx_disable_rx_int is only called by imx_startup,
> > let's integrate it into that function.
> > 
> > Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > ---
> > v2: new patch
> > ---
> >  drivers/tty/serial/imx.c | 39 ++++++++++-----------------------------
> >  1 file changed, 10 insertions(+), 29 deletions(-)
> 
> While testing this series, I noticed that sending a break on the serial port caused
> 
> imx-uart 2020000.serial: DMA transaction error.
> 
> Is that normal ?

I remember that J?rgen (added to To explictly) hit this or a similar
problem before, maybe he can commen?

Best regards
Uwe
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
