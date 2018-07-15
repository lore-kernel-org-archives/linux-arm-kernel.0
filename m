From: sean.wang@mediatek.com (Sean Wang)
Date: Sun, 15 Jul 2018 13:29:55 +0800
Subject: [SPAM]Re: [PATCH v5 2/7] serdev: add dev_pm_domain_attach|detach()
In-Reply-To: <ED7E5A98-81DC-41B9-9B9A-3EF4EBBED854@holtmann.org>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <d5904115ff1da38fe79b45fa3d59ef0688cea124.1531150733.git.sean.wang@mediatek.com>
 <ED7E5A98-81DC-41B9-9B9A-3EF4EBBED854@holtmann.org>
Message-ID: <1531632595.26214.31.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-07-14 at 18:27 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> > In order to open up the required power gate before any operation can be
> > effectively performed over the serial bus between CPU and serdev, it's
> > clearly essential to add common attach functions for PM domains to serdev
> > at the probe phase.
> > 
> > Similarly, the relevant dettach function for the PM domains should be
> > properly and reversely added at the remove phase.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-serial at vger.kernel.org
> > ---
> > drivers/tty/serdev/core.c | 15 ++++++++++++++-
> > 1 file changed, 14 insertions(+), 1 deletion(-)
> 
> can we take this through the serial subsystem? Or should I just take it when the driver is ready to be included?
> 
> Regards
> 
> Marcel
> 

I think it's better if the change is taken through serial subsystem
first.

Hi, Rob

do you have any comment? 

	Sean

> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
