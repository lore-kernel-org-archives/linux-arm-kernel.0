From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Jun 2018 16:55:27 +0530
Subject: [RESEND (again) PATCH] clkdev: don't call __of_clk_get_by_name()
 unnecessarily from clk_get()
In-Reply-To: <5824a382-00fc-0af3-097f-519a36c2d555@lechnology.com>
References: <20180625160440.10537-1-brgl@bgdev.pl>
 <5824a382-00fc-0af3-097f-519a36c2d555@lechnology.com>
Message-ID: <efeb5357-899e-acbb-22ad-6a9bc97013b5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 June 2018 04:32 AM, David Lechner wrote:
> On 06/25/2018 11:04 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> The way this function is implemented caused some confusion when
>> converting the TI DaVinci platform to using the common clock framework.
>>
>> Current kernel supports booting DaVinci boards both in device tree as
>> well as legacy, board-file mode. In the latter, we always end up
>> calling clk_get_sys() as of_node is NULL and __of_clk_get_by_name()
>> returns -ENOENT.
>>
>> It was not obvious at first glance how clk_get(dev, NULL) will work in
>> board-file mode since we always call __of_clk_get_by_name(). Let's make
>> it clearer by checking if of_node is NULL and skipping right to
>> clk_get_sys().
>>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: David Lechner <david@lechnology.com>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
> 
> Reviewed-by: David Lechner <david@lechnology.com>

I think Russell previously said that the patch looks good to him. So you
can probably just add it to his patch tracker.

http://www.arm.linux.org.uk/developer/patches/add.php

FWIW, you can also add:

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
