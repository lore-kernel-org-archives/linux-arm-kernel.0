From: dianders@chromium.org (Doug Anderson)
Date: Sun, 7 Sep 2014 21:15:16 -0700
Subject: [PATCH v2] i2c: rk3x: fix divisor calculation for SCL frequency
In-Reply-To: <1410147505-5930-1-git-send-email-addy.ke@rock-chips.com>
References: <1409884333-3544-1-git-send-email-addy.ke@rock-chips.com>
 <1410147505-5930-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAD=FV=WY=wS6P5f4BVfoyy8EWvrn9Mzh=wkOXBiEiJyQ-HNM=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Sun, Sep 7, 2014 at 8:38 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> I2C_CLKDIV register descripted in the previous version of
> RK3x chip manual is incorrect. Plus 1 is required.
>
> The correct formula:
> - T(SCL_HIGH) = T(PCLK) * (CLKDIVH + 1) * 8
> - T(SCL_LOW) = T(PCLK) * (CLKDIVL + 1) * 8
> - (SCL Divsor) = 8 * ((CLKDIVL + 1) + (CLKDIVH + 1))
> - SCL = PCLK / (CLK Divsor)
>
> It will be updated to the latest version of chip manual.
>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
> changes since v1:
> - make it more cleaner, suggested by Doug Anderson
>
>  drivers/i2c/busses/i2c-rk3x.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
