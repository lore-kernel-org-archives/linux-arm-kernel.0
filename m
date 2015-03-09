From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 09 Mar 2015 09:17:50 +0100
Subject: [PATCH 0/3] touchscreen: sun4i-ts: A10 (sun4i) has a different
 temperature curve
In-Reply-To: <20150308211117.GA23193@dtor-ws>
References: <1425848022-18001-1-git-send-email-hdegoede@redhat.com>
 <20150308211117.GA23193@dtor-ws>
Message-ID: <54FD572E.7040201@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08-03-15 22:11, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Sun, Mar 08, 2015 at 09:53:39PM +0100, Hans de Goede wrote:
>> Hi Dmitry, Maxime, et al.
>>
>> Here is a patch-set for the sun4i-ts driver temperature sensor support,
>> it consists of 2 fixes:
>>
>> 1) Use a better temperature curve for A10 SoCs to avoid reporting a way to
>> high temperature.
>>
>> 2) Start with reporting an "estimated" temperature of 40 degrees rather then
>> returning -EAGAIN until we get the first temperature ready interrupt to avoid
>> the kernel tempzone core logging errors because of our -EAGAIN return.
>
> No, I think we better teach thermal core not to complain about
> -EAGAINs.

I was wondering if that would not be a better fix myself, so ack. I'll go do
a patch for that and submit it to the thermalzone maintainer.

Regards,

Hans
