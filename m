From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 26 Jul 2013 16:10:08 -0700
Subject: [PATCH v2 2/3] serial: mxs: enable the DMA only when the RTS/CTS
 is valid
In-Reply-To: <51E648C2.3010304@freescale.com>
References: <1373957732-16638-1-git-send-email-b32955@freescale.com>
 <1373957732-16638-3-git-send-email-b32955@freescale.com>
 <20130716095449.GS12139@pengutronix.de>
 <51E648C2.3010304@freescale.com>
Message-ID: <20130726231008.GA32627@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 03:33:22PM +0800, Huang Shijie wrote:
> ? 2013?07?16? 17:54, Uwe Kleine-K?nig ??:
> >On Tue, Jul 16, 2013 at 02:55:31PM +0800, Huang Shijie wrote:
> >>The original DMA support works only when RTS/CTS is enabled.
> >What is original here?
> >
> i will add more information for this in the next version.
> >>But after several patches, DMA support has lost this limit.
> >This is still misleading.
> >
> >>This patch adds an optional property for the UART DT node
> >>which indicates the UART has RTS and CTS lines.
> >>
> >>This patch also adds a macro MXS_AUART_RTSCTS, and uses it to check
> >>RTS/CTS before we enable the DMA for the UART.
> >I still think this should go to stable. The options are:
> >
> >	a) also take patch 1 into stable
> >	b) apply this patch without patch 1
> >
> >I don't know if option a) is OK, b) is probably preferable. And as Greg
> to Greg:
> 
> I think a) is ok to me. what's your opinion?

Please reorder them, making patch 2 first, and mark it for stable, then
do patch 1, and the rest, so I don't have to take non-needed patches
into the stable tree.

thanks,

greg k-h
