From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 5 Aug 2013 15:02:35 +0800
Subject: [PATCH v3 1/3] serial: mxs: enable the DMA only when the RTS/CTS
 is valid
In-Reply-To: <1375538956-15862-2-git-send-email-shijie8@gmail.com>
References: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
 <1375538956-15862-2-git-send-email-shijie8@gmail.com>
Message-ID: <20130805070235.GA30211@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 03, 2013 at 10:09:14AM -0400, Huang Shijie wrote:
> From: Huang Shijie <b32955@freescale.com>
> 
> The original DMA support works only when RTS/CTS is enabled.
> (see the "e800163 serial: mxs-auart: add the DMA support for mx28")
> But after several patches, DMA support has lost this limit.
> (see the "bcc20f9 serial: mxs-auart: move to use generic DMA helper")
> 
> So an UART without the RTS/CTS lines may also enables the DMA support,
> in which case the UART may gets unpredictable results.
> 
> This patch adds an optional property for the UART DT node
> which indicates the UART has RTS and CTS lines, and it also means you
> enable the DMA support for this UART.
> 
> This patch also adds a macro MXS_AUART_RTSCTS, and uses it to check
> RTS/CTS before we enable the DMA for the UART.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> Signed-off-by: Huang Shijie <shijie8@gmail.com>
> ---
>  .../bindings/tty/serial/fsl-mxs-auart.txt          |    4 ++++
>  drivers/tty/serial/mxs-auart.c                     |    7 ++++++-
>  2 files changed, 10 insertions(+), 1 deletions(-)

I don't see how this patch follows the stable kernel guidelines, so I'll
take the marking of it off, and queue it up for 3.12.

thanks,

greg k-h
