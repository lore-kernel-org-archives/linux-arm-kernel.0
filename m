From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 16 Oct 2015 13:23:26 +0800
Subject: [PATCH v4 1/4] dt-bindings: mailbox: Document Hi6220 mailbox
 driver
In-Reply-To: <CABb+yY0S18ShH3+sBnq=mOYMY=f4BNp947cUJae4YPfR=wPGGg@mail.gmail.com>
References: <1444667535-16948-1-git-send-email-leo.yan@linaro.org>
 <1444667535-16948-2-git-send-email-leo.yan@linaro.org>
 <CABb+yY0S18ShH3+sBnq=mOYMY=f4BNp947cUJae4YPfR=wPGGg@mail.gmail.com>
Message-ID: <20151016052326.GA3226@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

Thanks for review.

On Fri, Oct 16, 2015 at 10:26:48AM +0530, Jassi Brar wrote:
> On Mon, Oct 12, 2015 at 10:02 PM, Leo Yan <leo.yan@linaro.org> wrote:
> 
> > +
> > +Mailbox Device Node:
> > +====================
> > +
> > +Required properties:
> > +--------------------
> > +- compatible:          Shall be "hisilicon,hi6220-mbox"
> > +- reg:                 Contains the mailbox register address range (base
> > +                       address and length); the first item is for IPC
> > +                       registers, the second item is shared buffer for
> > +                       slots.
> >
> Is the shared-buffer a part of mailbox controller or just regular
> memory that could be used for purposes other than mailbox also? If
> latter, please remove it from here.

The shared-buffer is part of mailbox controller, this region cannot be
dynamically allocated for other purpose; it's hardcode by MCU firmware.

> > +Mailbox client
> > +===============
> > +
> > +"mboxes" and the optional "mbox-names" (please see
> > +Documentation/devicetree/bindings/mailbox/mailbox.txt for details). Each value
> > +of the mboxes property should contain a phandle to the mailbox controller
> > +device node and second argument is the channel index. It must be 0 (hardware
> > +support only one channel).
> >
> sorry, what must be 0?  You have MBOX_CHAN_MAX and MBOX_CHAN_NUM as 32
> and 2 in the driver.

Will fix it.

Thanks,
Leo Yan
