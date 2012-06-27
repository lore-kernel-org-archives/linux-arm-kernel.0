From: linuxzsc@gmail.com (Richard Zhao)
Date: Wed, 27 Jun 2012 19:37:52 +0800
Subject: [PATCH] usb: chipidea: cleanup dma_pool if udc_start() fails
In-Reply-To: <20120626214416.GB4878@kroah.com>
References: <1340615374-21352-1-git-send-email-mkl@pengutronix.de>
 <4FE82B67.8010601@pengutronix.de> <20120626214416.GB4878@kroah.com>
Message-ID: <CANg6MZiqm769t+BqqmyveaiF64STHLHfTvQpB4T0kAMd9PfLgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 5:44 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Jun 25, 2012 at 11:12:07AM +0200, Marc Kleine-Budde wrote:
>> On 06/25/2012 11:09 AM, Marc Kleine-Budde wrote:
>> > If udc_start() fails the qh_pool dma-pool cannot be closed because
>> > it's still in use. This patch factors out the dma_pool_free() loop
>> > into destroy_eps() and calls it in the error path of udc_start(),
>> > too.
>> >
>> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> > ---
>>
>> This patch applies on top of Richard's just published imx-chipindea
>> tree. (https://github.com/riczhao/kernel-imx/commits/topics/usb-driver)
>
> As that tree is still changing, is someone going to pick this up and add
> it to that tree?
It's my tree.
Marc, If you agree, I can queue it and send it out when my patch get upstreamed.

Thanks
Richard
>
> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
