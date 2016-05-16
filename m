From: dianders@chromium.org (Doug Anderson)
Date: Mon, 16 May 2016 13:17:38 -0700
Subject: [PATCH v10 0/8] add i2c driver supported for rk3399
In-Reply-To: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAD=FV=VqEpmODcnKOGb5P=Fu84c5pBOJXD9pfFMRc2aERfWmRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 16, 2016 at 6:57 AM, David Wu <david.wu@rock-chips.com> wrote:
> There are three points differert from others:
>  - new method to caculate i2c timings for rk3399
>  - pclk and function clk are separated at rk3399
>  - add fast-plus mode supported for rk3399
>
> David Wu (8):
>   i2c: rk3x: add documentation to fields in "struct rk3x_i2c"
>   i2c: rk3x: use struct "rk3x_i2c_calced_timings"
>   i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
>   i2c: rk3x: Change SoC data to not use array
>   i2c: rk3x: Move spec timing data to "static const" structs
>   dt-bindings: i2c: rk3x: add support for rk3399
>   i2c: rk3x: add i2c support for rk3399 soc
>   i2c: rk3x: support fast-mode plus for rk3399
>
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  16 +-
>  drivers/i2c/busses/i2c-rk3x.c                      | 498 +++++++++++++++++----
>  2 files changed, 434 insertions(+), 80 deletions(-)

I haven't put these on the scope or anything, but I have:

* Tested that my i2c busses on rk3288-veyron still seem to work OK
after these patches.

* Tested that my i2c busses on an rk3399 board seem to work after
these patches (plus device tree changes).

Thus, for the series:

Tested-by: Douglas Anderson <dianders@chromium.org>

...possibly could leave off the Tested-by tag for the last in the
series since I have no Fast Mode Plus devices to test against.  ;)

-Doug
