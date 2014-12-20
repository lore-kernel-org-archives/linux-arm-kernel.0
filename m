From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 20 Dec 2014 11:44:37 +0100
Subject: [PATCH v3] input: Add new sun4i-lradc-keys driver
In-Reply-To: <20141218175153.GA34618@dtor-ws>
References: <1418898193-9160-1-git-send-email-hdegoede@redhat.com>
 <20141218175153.GA34618@dtor-ws>
Message-ID: <54955315.3030603@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

On 18-12-14 18:51, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Thu, Dec 18, 2014 at 11:23:13AM +0100, Hans de Goede wrote:
>> Allwinnner sunxi SoCs have a low resolution adc (called lradc) which is
>> specifically designed to have various (tablet) keys (ie home, back, search,
>> etc). attached to it using a resistor network. This adds a driver for this.
>>
>> There are 2 channels, currently this driver only supports chan0 since there
>> are no boards known to use chan1.
>>
>> This has been tested on an olimex a10s-olinuxino-micro, a13-olinuxino, and
>> a20-olinuxino-micro.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> --
>> Changes in v2:
>> -Change devicetree bindings to use a per key subnode, like gpio-keys does
>> Changes in v3:
>> -Handle keyup irq flag before irqdown, in case we get both at once
>
> Thank you for making changes. Can you please tell me if the driver still
> works if you drop the patch below on top of it? The changes are:
>
> - split DT parsing into a separate function;
> - make sure keymap is not empty;
> - change 'ret' variable to 'error';

The proposed changes look good, and I've given them a test-spin and everything
still works fine.

Thanks & Regards,

Hans
