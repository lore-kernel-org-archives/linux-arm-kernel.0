From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Nov 2012 22:14:58 -0800
Subject: [PATCH 2/2] i2c-s3c2410: Add bus arbitration implementation
In-Reply-To: <CAPnjgZ0atD3k=gT0vjgkLO_SA8DMak6SiT6nZ_2T6WFqtK0szQ@mail.gmail.com>
References: <1354165536-18529-1-git-send-email-ch.naveen@samsung.com>
 <1354165536-18529-3-git-send-email-ch.naveen@samsung.com>
 <20121129163448.GA3761@sirena.org.uk>
 <CAPnjgZ0atD3k=gT0vjgkLO_SA8DMak6SiT6nZ_2T6WFqtK0szQ@mail.gmail.com>
Message-ID: <CAOesGMgE0JEHsdySpua34_kbWi1+z4n4UdW0kumiJEROi7O2pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 6:13 PM, Simon Glass <sjg@chromium.org> wrote:
> +Olof
>
> On Thu, Nov 29, 2012 at 8:34 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Thu, Nov 29, 2012 at 10:35:35AM +0530, Naveen Krishna Chatradhi wrote:
>>
>>> The arbitrator is a general purpose function which uses two GPIOs to
>>> communicate with another device to claim/release a bus. We use it to
>>> arbitrate an i2c port between the AP and the EC.
>>
>> Should this not be layerd on top of the I2C controller rather than part
>> of the controller driver?  It doesn't seem terribly controller specific.
>
> It was originally done separately but I think it was felt that this
> was overly complex. Olof can you please comment on this?

it is indeed not controller specific per se, but we are unaware of any
other platform/driver using it. So, it seemed reasonable to implement
it in the driver as long as we have only one user; if another one
comes along it's of course better to move it to the common i2c code.

At least that was my opinion at the time. I could be convinced
otherwise if someone else has strong opinions on the matter.


-Olof
