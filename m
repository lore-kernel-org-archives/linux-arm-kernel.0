From: hramrach@gmail.com (Michal Suchanek)
Date: Thu, 20 Aug 2015 21:45:07 +0200
Subject: [PATCH 3/9] spi: sunxi: check that transfer speed is non-zero
In-Reply-To: <20150820144836.GV30520@lukather>
References: <cover.1440080122.git.hramrach@gmail.com>
 <3688fab67e7cdc7bcbff73dfd6b0fcdcc4e79eb6.1440080122.git.hramrach@gmail.com>
 <20150820144836.GV30520@lukather>
Message-ID: <CAOMqctSfdxWeWDogzHxONE+Qxf7vp6rJnBmxECV89PQO0hXARg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 August 2015 at 16:48, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Aug 20, 2015 at 02:19:46PM -0000, Michal Suchanek wrote:
>> When the maximum transfer speed is not set for a SPI slave the value
>> remains 0 and the code in sunxi SPI divides by it. Use an arbitrary
>> speed instead in that case.
>>
>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>
> spi->max_speed_hz is set using the spi-max-frequency property, and
> spi->will error out if that property isn't set. What am I missing?
>

Spidev I guess.

You can set the speed to arbitrary value from userspace at any time
using the spidev ioctls.

Thanks

Michal
