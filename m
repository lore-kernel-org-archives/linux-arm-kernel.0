From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 4 Nov 2013 15:05:37 -0200
Subject: [PATCHv4][ 5/6] ARM: dts: i.MX35: Add display support.
In-Reply-To: <1383581724-14817-5-git-send-email-denis@eukrea.com>
References: <1383581724-14817-1-git-send-email-denis@eukrea.com>
 <1383581724-14817-5-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5AScU=eNjnoBxUHibJihZewQdjT-PB-4yZ-fmQMgc4ZHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Mon, Nov 4, 2013 at 2:15 PM, Denis Carikli <denis@eukrea.com> wrote:
> +                       ipu: ipu at 53fc0000 {
> +                               compatible = "fsl,imx31-ipu";
> +                               reg = < 0x53fc0000 0x5f
> +                                       0x53fc0088 0x2b >;
> +                               interrupts = <42 41>;
> +                               clocks = <&clks 55>;
> +                               status = "disabled";
> +                       };
> +
> +                       lcdc: mx3fb at 53fc00b4 {
> +                               compatible = "fsl,mx3-fb";
> +                               reg = <0x53fc00b4 0x0b>;
> +                               clocks = <&clks 55>;
> +                               status = "disabled";
> +                       };

MX35 Reference Manual states that the IPU address range is 0x53fc0000
- 0x53fc3fff

There is no 'lcdc' peripheral listed there, so I don't think 'lcdc'
should be included here.

Regards,

Fabio Estevam
