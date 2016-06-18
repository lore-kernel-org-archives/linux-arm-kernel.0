From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 18 Jun 2016 14:01:08 +0200
Subject: [PATCH] arm64: dts: rockchip: add i2c nodes for rk3399
In-Reply-To: <1463429371-10950-1-git-send-email-dianders@chromium.org>
References: <1463429371-10950-1-git-send-email-dianders@chromium.org>
Message-ID: <1633653.D0508meTWe@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 16. Mai 2016, 13:09:31 schrieb Douglas Anderson:
> From: David Wu <david.wu@rock-chips.com>
> 
> We've got 9 (count em!) i2c controllers on rk3399, some of which are in
> the PMU power domain and some of which are normal peripherals.  Add them
> all to the main rk3399 dtsi file so future patches can turn them on in
> the board dts files.
> 
> Note: by default we try to set the i2c clock rate to 200 MHz so that we
> can achieve good i2c functional clock rates.  200 MHz gives us the
> ability to make very close to 100 kHz / 400 kHz / 1 MHz rates.  If
> boards want to tune clock rates further they can always override.
> Possibly boards could want to tune this if:
> - they wanted to save an infinitesimal amount of power and they knew
>   their i2c bus was slow anyway.  Since we gate the functional clock
>   when the i2c bus is not active, power savings would only be while i2c
>   transfers were happening and probably won't be very big anyway.
> - they wanted to eek out a bit more speed by carefully tuning the source
>   clock to make divisions work out perfectly, accounting for the rise /
>   fall time measured on an actual board.
> 
> Note also that we still request 200 MHz for the PMU i2c busses even
> though we expect that we won't make that exactly (currently PPLL is 676
> MHz which gives us 169 MHz).
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> [dianders: wrote desc; put in assigned-clocks; reordered nodes]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied to my dts64 branch for 4.8

Thanks
Heiko
