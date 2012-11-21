From: dianders@chromium.org (Doug Anderson)
Date: Wed, 21 Nov 2012 10:33:40 -0800
Subject: [PATCH 2/2] i2c: s3c2410: Get the i2c bus number from alias id
In-Reply-To: <20121121040913.GA13280@sirena.org.uk>
References: <1353450428-2615-1-git-send-email-dianders@chromium.org>
 <1353450428-2615-2-git-send-email-dianders@chromium.org>
 <20121121040913.GA13280@sirena.org.uk>
Message-ID: <CAD=FV=V-59u-J40G3x9oK5phUX-5pa9xJLN9QnGJCRqGfc_2ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 8:09 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Nov 20, 2012 at 02:27:04PM -0800, Doug Anderson wrote:
>> From: Padmavathi Venna <padma.v@samsung.com>
>>
>> Get the i2c bus number that the device is connected to using the alias
>> id.  This makes debugging / grokking of kernel messages much easier.
>
> This doesn't look like a s3c2410 specific change - it's a generic device
> tree issue.  This suggests that it sohuld be implemented in the
> framework so that all I2C controllers with DT can use it.

Good suggestion.  I have posted a series with the title "Add automatic
bus number support for i2c busses with device tree".  It contains the
i2c-core patch as well as a patch removing similar code from the pxa
i2c driver.

Kukjin: please consider this patch abandoned and superseded by the new
i2c-core patch.  As Olof said, the patch for adding aliases for
exynos4 should still be fine to apply.


Thanks!

-Doug
