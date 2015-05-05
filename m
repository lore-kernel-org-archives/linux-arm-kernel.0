From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 05 May 2015 13:32:14 -0600
Subject: [PATCH 2/3 v7] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <CABb+yY2V5dXQ5fH3s2T4-j6-z68bOzaeUN9WQoNze2mc-quD+A@mail.gmail.com>
References: <1430254460-26754-1-git-send-email-eric@anholt.net>	<1430327374-6562-1-git-send-email-eric@anholt.net>	<CABb+yY0+Dd6RMJfmcqWrJfsSkPS8KjtpctJteoTZrj3QttJ71g@mail.gmail.com>	<871tivq1rp.fsf@eliezer.anholt.net>
 <CABb+yY2V5dXQ5fH3s2T4-j6-z68bOzaeUN9WQoNze2mc-quD+A@mail.gmail.com>
Message-ID: <55491ABE.40300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2015 08:30 PM, Jassi Brar wrote:
> On Tue, May 5, 2015 at 6:27 AM, Eric Anholt <eric@anholt.net> wrote:
>> Jassi Brar <jassisinghbrar@gmail.com> writes:
>>
>>> On Wed, Apr 29, 2015 at 10:39 PM, Eric Anholt <eric@anholt.net> wrote:
>>>
>>>> +
>>>> +struct bcm2835_mbox {
>>>> +       struct device *dev;
>>>> +       void __iomem *regs;
>>>> +       spinlock_t lock;
>>>> +       struct mbox_controller controller;
>>>> +};
>>>> +
>>>> +static struct bcm2835_mbox *mbox;
>>>> +
>>>> +static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
>>>> +{
>>>> +       struct device *dev = mbox->dev;
>>>> +       struct mbox_chan *link = &mbox->controller.chans[0];
>>>> +
>>> I learn from Stephen's other post that the controller could have
>>> multiple channels. In which case this driver is poorly setup. Actually
>>> if the driver was designed properly there isn't anything special to be
>>> done.
>>>   Here you choose to waste 'dev_id' and hard-code dereferencing to channel-0
>>
>> There's only the one channel according to the docs.  I wish we wouldn't
>> get derailed by speculation on the list when the documentation is
>> available. :(
>>
> Can I have the pointer to the doc please, if its publicly available.

https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
