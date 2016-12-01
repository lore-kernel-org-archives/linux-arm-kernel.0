From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 01 Dec 2016 13:05:03 +0100
Subject: [resend v2: PATCH 1/2] dt-bindings: Document the hi3660 reset
 bindings
In-Reply-To: <1480553321-17400-2-git-send-email-zhangfei.gao@linaro.org>
References: <1480553321-17400-1-git-send-email-zhangfei.gao@linaro.org>
 <1480553321-17400-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <3900806.3NUubBDb0Q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 1, 2016 8:48:40 AM CET Zhangfei Gao wrote:
> +               hisi,reset-bits = <0x20 0x8             /* 0: i2c0 */
> +                                  0x20 0x10            /* 1: i2c1 */
> +                                  0x20 0x20            /* 2: i2c2 */
> +                                  0x20 0x8000000>;     /* 3: i2c6 */
> +       };
> +
> +Specifying reset lines connected to IP modules
> +==============================================
> +example:
> +
> +        i2c0: i2c at ..... {
> +                ...
> +               resets = <&iomcu_rst 0>;
> +                ...
> +        };

I don't really like this approach, since now the information is
in two places. Why not put the data into the reset specifier
directly when it is used?

Also the format seems a little too close to the actual register
layout and could be a little more abstract, using bit numbers instead
of a bitmask and register numbers instead of offsets.

	Arnd
