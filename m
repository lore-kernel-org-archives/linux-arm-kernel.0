From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 13 Jun 2010 18:47:54 +0800
Subject: [PATCH] mioa701: fix camera regression
In-Reply-To: <87pr01mnw1.fsf@free.fr>
References: <1275514190-32006-1-git-send-email-robert.jarzmik@free.fr>
	<Pine.LNX.4.64.1006032058380.19573@axis700.grange>
	<87pr01mnw1.fsf@free.fr>
Message-ID: <AANLkTikvIN3bnxEQrz9ZtTB4vhg3nygx8JJ5aqwQlfbD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 9, 2010 at 1:31 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> On Wed, 2 Jun 2010, Robert Jarzmik wrote:
>>
>>> Since commit a48c24a696f0d93c49f913b7818e9819612b1f4e, the
>>> camera is not working anymore.
>>>
>>> After the v4l2 migration, the mt9m111 camera board
>>> information was not passed to the i2c layer anymore, but
>>> stored for future use of v4l2 (through soc_camera).
>>>
>>> Because mioa701_i2c_devices[] was tagged as "__initdata",
>>> and because after the v4l2 migration, the new structure
>>> "iclink" references it, the mt9m111 driver is not probed
>>> anymore, as part of "iclink" is not valid (discarded after
>>> kernel init).
>>>
>>> Although there is not compilation error, nor runtime oops,
>>> this patch restores a working camera on the mioa701 board.
>>>
>>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>>
>> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>
>>>
>>> --
>>> Eric, could you schedule that into your fix branch please ?
>
> Ping.
>

Sorry. Now merged.
