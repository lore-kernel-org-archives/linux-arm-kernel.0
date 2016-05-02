From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 2 May 2016 07:44:58 -0700
Subject: [PATCH v2] nvmem/mxs-ocotp: fix buffer overflow in read
In-Reply-To: <57275C69.9060902@i2se.com>
References: <1f26dfe5-c75f-39df-e21e-77aeea408258@meduna.org>
 <57275C69.9060902@i2se.com>
Message-ID: <20160502144458.GA15555@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 03:55:53PM +0200, Stefan Wahren wrote:
> Hi Srinivas,
> hi Greg,
> 
> Am 27.04.2016 um 14:39 schrieb Stanislav Meduna:
> > This patch fixes the issue where the mxs_ocotp_read is reading
> > the ocotp in reg_size steps but decrements the remaining size
> > by 1. The number of iterations is thus four times higher,
> > overwriting the area behind the output buffer.
> >
> > Fixes: c01e9a11ab6f ("nvmem: add driver for ocotp in i.MX23 and i.MX28")
> > Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Signed-off-by: Stanislav Meduna <stano@meduna.org>
> 
> any change to get this critical fix into 4.6?

This is the first I've seen this patch :(

Can you resend it in a format I can apply it in?

thanks,

greg k-h
