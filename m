From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 6 Dec 2016 00:39:27 +0900
Subject: [PATCH] ARM: dts: orion5x: fix number of sata port for
 linkstation ls-gl
In-Reply-To: <20161201151112.930-1-rogershimizu@gmail.com>
References: <20161201151112.930-1-rogershimizu@gmail.com>
Message-ID: <CAEQ9gEkp+bS10ZQ_0UJqvWMNgTkmtWGqcZviRZk0+pQaZFw_vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC Arnd Bergmann]

On Fri, Dec 2, 2016 at 12:11 AM, Roger Shimizu <rogershimizu@gmail.com> wrote:
> Bug report from Debian [0] shows there's minor changed model of
> Linkstation LS-GL that uses the 2nd SATA port of the SoC.
> So it's necessary to enable two SATA ports, though for that specific
> model only the 2nd one is used.
>
> [0] https://bugs.debian.org/845611
>
> Fixes: b1742ffa9ddb ("ARM: dts: orion5x: add device tree for buffalo linkstation ls-gl")
> Reported-by: Ryan Tandy <ryan@nardis.ca>
> Tested-by: Ryan Tandy <ryan@nardis.ca>
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
> ---
>  arch/arm/boot/dts/orion5x-linkstation-lsgl.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
> index 1cf644b..51dc734 100644
> --- a/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
> +++ b/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
> @@ -82,6 +82,10 @@
>         gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
>  };
>
> +&sata {
> +       nr-ports = <2>;
> +};
> +
>  &ehci1 {
>         status = "okay";
>  };
> --
> 2.10.2
>

Is there any chance to get this simple fix into v4.9 or next v4.10?
Thank you!
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
