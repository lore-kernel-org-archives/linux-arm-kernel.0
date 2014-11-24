From: sonnyrao@chromium.org (Sonny Rao)
Date: Sun, 23 Nov 2014 18:08:05 -0800
Subject: [PATCH] clk: rockchip: rk3288 export i2s0_clkout for use in DT
In-Reply-To: <2905614.GvjeQFvyvc@diego>
References: <1416381319-31117-1-git-send-email-sonnyrao@chromium.org>
 <2905614.GvjeQFvyvc@diego>
Message-ID: <CAPz6YkXSdTode-eu=HuMR1H8x9APi=xOQA+_4D6K4yXEThLQ5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 23, 2014 at 4:07 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Sonny,
>
> Am Dienstag, 18. November 2014, 23:15:19 schrieb Sonny Rao:
>> This exposes the clock that comes out of the i2s block which generally
>> goes to the audio codec.
>>
>> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>> ---
>>  drivers/clk/rockchip/clk-rk3288.c      | 3 ++-
>>  include/dt-bindings/clock/rk3288-cru.h | 1 +
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>
> [...]
>
>> diff --git a/include/dt-bindings/clock/rk3288-cru.h
>> b/include/dt-bindings/clock/rk3288-cru.h index 100a08c..4acc730 100644
>> --- a/include/dt-bindings/clock/rk3288-cru.h
>> +++ b/include/dt-bindings/clock/rk3288-cru.h
>> @@ -71,6 +71,7 @@
>>  #define SCLK_HDMI_CEC                110
>>  #define SCLK_HEVC_CABAC              111
>>  #define SCLK_HEVC_CORE               112
>> +#define SCLK_I2S0_OUT           113
>>
>>  #define DCLK_VOP0            190
>>  #define DCLK_VOP1            191
>
> just to get branches right, do you plan on sending a patch using this new
> clock-id in a devicetree file in time for 3.19 (i.e. during the next week).
>
> If you plan on doing this, we'll need a 2-patch series like Alexandru did for
> the mmc phases [because we would need a shared branch between clk and dts
> branches]. If not the patch can stay as it is.
>

Hi, I'm not planning on sending anything with this new clock in the
immediate future, so I think you can take it as is.  Eventually, we
will submit something that uses it for the audio codec on Pinky using
simple-card but I don't have that ready yet.  Thanks!

> Thanks
> Heiko
