From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 1 Jul 2018 10:24:09 -0300
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Select ULPI support
In-Reply-To: <20180701132008.GP4348@dragon>
References: <1529930043-6387-1-git-send-email-festevam@gmail.com>
 <1529930043-6387-2-git-send-email-festevam@gmail.com>
 <20180701132008.GP4348@dragon>
Message-ID: <CAOMZO5BZgbj-jZAiFB_yovEc3np2FNsON37-Acy6PBWtRHP3cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Sun, Jul 1, 2018 at 10:20 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Mon, Jun 25, 2018 at 09:34:03AM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> Select CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS so that
>> USB ULPI can be functional on some boards like imx51-babbge.
>>
>> This fixes a kernel hang in 4.18-rc1 on i.mx51-babbage when
>> the bootloader does not initialize USB.
>
> Is this hang a regression or what?

Yes, it is a regression in 4.18-rc1 caused by commit  03e6275ae381
("usb: chipidea: Fix ULPI on imx51")

I have also sent a USB kernel patch that avoids the hang, but we need
both the USB patch + the defconfig change in 4.18.

Thanks
