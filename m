From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 May 2013 08:35:04 +0200
Subject: [PATCH 20/39] usb: musb: ux500: move channel number knowledge
 into the driver
In-Reply-To: <20130515201439.GA10141@balto.lan>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-21-git-send-email-lee.jones@linaro.org>
 <CACRpkdYjjDp+7hzGtAchyy3+5Vxc8jK5THGCETkAO_V9Hj9Ssw@mail.gmail.com>
 <20130515201439.GA10141@balto.lan>
Message-ID: <CACRpkdaJ7_p=ggax2gE86ea75Da7p9xB6A6Kte36j2LZq6_TVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 10:14 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:
> On Wed, May 15, 2013 at 07:18:01PM +0200, Linus Walleij wrote:
>> On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> > For all ux500 based platforms the maximum number of end-points are used.
>> > Move this knowledge into the driver so we can relinquish the burden from
>> > platform data. This also removes quite a bit of complexity from the driver
>> > and will aid us when we come to enable the driver for Device Tree.
>> >
>> > Cc: Felipe Balbi <balbi@ti.com>
>> > Cc: linux-usb at vger.kernel.org
>> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> > Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>
>> I guess this stuff is dependent on the stuff Fabio has recently sent to
>> Felipe for the ux500 musb DMA so these musb patches should
>> primarily go through his tree.
>
> Not really, I only sent some coding style fix for the dma driver, as
> almost all of my work was in the usb phy files.  I also checked my
> latest series against Lee's tree and the two seems to merge without any
> conflict, so as far as I'm concerned it's really up to you and Felipe.

OK so Felipe can merge these smallish patches to musb, fine...

The other (DMA) stuff needs to be merged together with the rest
of the DMA40 series, so here basically Felipe needs an indication
if he can ACK it so I merge it through ARM SoC without colissions
and it sounds like we can make the assumption that this will work.

Yours,
Linus Walleij
