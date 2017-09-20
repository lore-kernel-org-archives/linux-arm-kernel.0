From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Sep 2017 06:39:16 -0300
Subject: [PATCH 1/2] dts: display5: Device tree description of LWN's
 DISPLAY5 board
In-Reply-To: <f203efc5-b85c-aa3d-0dc6-929ea348e5f6@denx.de>
References: <1505746765-965-1-git-send-email-lukma@denx.de>
 <CAOMZO5Du4gH1jwcP4ssRPD17GsEAVERpkNBD7W2z5f+4TAd=nA@mail.gmail.com>
 <f203efc5-b85c-aa3d-0dc6-929ea348e5f6@denx.de>
Message-ID: <CAOMZO5CHR14LWqkgpSiPnMV_6X+Fq=fe-KmE5CrdiqxRUyT8xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Wed, Sep 20, 2017 at 6:22 AM, ?ukasz Majewski <lukma@denx.de> wrote:

> Could you be more specific here?
>
> The 0x80000000 corresponds to IMX_NO_PAD_CTL in pinctrl-imx.c, which
> prevents from manual GPIO control.
>
> The 0x80000000 value is the IOMUXC_SW_PAD_CTL_PAD_CSI0_DATA11 (0x020E_0654)
> config data (16 bits only -> 0x0).
>
> Writing 0x0 to this register is perfectly fine for my application.
>
>
> I'm a bit in doubt to what I shall do more?

As per the Reference Manual, the POR reset for
IOMUXC_SW_PAD_CTL_PAD_CSI0_DATA11 is 0x1b0b0.

0x80000000 tells the kernel to not touch this IOMUX and use whatever
value comes from the bootloader.

If your bootloader does not touch this register, then you probably
read 0x1b0b0 from it.

In this case, please do this instead:

MX6QDL_PAD_CSI0_DAT11__GPIO5_IO29 0x1b0b0
