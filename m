From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 13 Sep 2015 13:32:34 +0200
Subject: [PATCH] ARM: dts: Add the hdmi-ddc pinctrl settings for rk3288
In-Reply-To: <1441230862-17376-1-git-send-email-dianders@chromium.org>
References: <1441230862-17376-1-git-send-email-dianders@chromium.org>
Message-ID: <1460847.PVSDMeWNWs@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 2. September 2015, 14:54:22 schrieb Douglas Anderson:
> The pins for i2c5 can either be configured as "I2C5" which means that
> they're controlled by the normal RK3288 I2C controller or as "EDP / HDMI
> I2C".  It's unclear why EDP is referenced here since apparently setting
> the mux to this position enables I2C communication using the dw_hdmi
> block with a patch like <https://patchwork.kernel.org/patch/7098101/>.
> 
> There appear to be some reasons why using the builtin I2C controller in
> dw_hdmi is better than using the normal RK3288 I2C controller, so boards
> based on rk3288 might eventually want to use this pinmux if it's known
> to work.
> 
> Once driver support in dw_hdmi lands, boards would use this by selecting
> this pinctrl for the HDMI block and then _not_ specifying a ddc-i2c-bus
> and _not_ setting the status to "okay" for i2c5 (which uses the same
> pins).
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied to my dts branch for 4.4


Thanks
Heiko
