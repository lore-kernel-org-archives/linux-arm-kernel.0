From: balbi@ti.com (Felipe Balbi)
Date: Tue, 10 Dec 2013 10:31:24 -0600
Subject: [PATCH v3 03/15] mfd: menelaus: Convert to threaded irq
In-Reply-To: <20131210093213.GV12675@lee--X1>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-3-git-send-email-balbi@ti.com>
 <20131210093213.GV12675@lee--X1>
Message-ID: <20131210163124.GD22750@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 10, 2013 at 09:32:13AM +0000, Lee Jones wrote:
> On Mon, 09 Dec 2013, Felipe Balbi wrote:
> 
> > We don't need that extra workqueue when we have generic threaded irq
> > handlers support. This patch just moves over to threaded irqs and
> > deletes the unnecessary workqueue.
> > 
> > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/mfd/menelaus.c | 29 ++++-------------------------
> >  1 file changed, 4 insertions(+), 25 deletions(-)
> 
> <snip>
> 
> > -		err = request_irq(client->irq, menelaus_irq, 0,
> > -				  DRIVER_NAME, menelaus);
> > +		err = request_threaded_irq(client->irq, NULL, menelaus_irq,
> > +				IRQF_ONESHOT, DRIVER_NAME, menelaus);
> 
> devm_* managed resources please.

that would be subject to another patch. One that converts to devm_* on
the entire driver.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/a7081e9e/attachment-0001.sig>
