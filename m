From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Fri, 1 Dec 2017 10:02:37 +0100
Subject: [PATCH v4 4/6] ARM: dts: imx6qdl: Add Variscite DART-MX6 SoM
 support
In-Reply-To: <d30a3015-afbb-cd88-ee01-4222339a2807@baylibre.com>
References: <1511950857-19292-1-git-send-email-narmstrong@baylibre.com>
 <1511950857-19292-5-git-send-email-narmstrong@baylibre.com>
 <20171130003912.GB22908@dragon>
 <d30a3015-afbb-cd88-ee01-4222339a2807@baylibre.com>
Message-ID: <CAOFm3uEY8+B8mhdcSLexdF8U8rq9kU2dM+ix=A_f+5kU_iR=nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 1, 2017 at 9:54 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 30/11/2017 01:39, Shawn Guo wrote:
>> On Wed, Nov 29, 2017 at 11:20:55AM +0100, Neil Armstrong wrote:
>>> This patch adds support for the Variscite DART-MX6 SoM with :
>>> - i.MX6 Quad or Dual Lite SoC
>>> - 1Gb/2Gb LPDDR2
>>> - 4-64 GB eMMC
>>> - Camera Interface
>>> - HDMI+CEC interface
>>> - LVDS / DSI / Parallel RGB interfaces
>>> - Ethernet RGMII interface
>>> - On-SoM Wi-Fi/Bluetooth with WiLink wl1835 SDIO Module
>>> - SD/MMC/SDIO interface
>>> - USB Host + USB OTG interface
>>> - I2C interfaces
>>> - SPI interfaces
>>> - PCI-Express 2.0 interface
>>> - on-SoM Audio Codec with HP/Line-In interfaces + DMIC interface
>>> - Digital Audio interface
>>> - S/PDIF interface
>>>
>>> Product website : http://www.variscite.com/products/system-on-module-som/cortex-a9/dart-mx6-cpu-freescale-imx6
>>>
>>> Support is handled with a SoM-centric dtsi exporting the default interfaces
>>> along the default pinmuxing to be enabled by the board dts file.
>>>
>>> Only board-independent devices like WiFi, eMMC or PMIC are enabled in the dtsi.
>>>
>>> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> Looks pretty good.  Only a couple of minor comments.
>>
>>> ---
>>>  arch/arm/boot/dts/imx6qdl-var-dart.dtsi | 504 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 504 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/imx6qdl-var-dart.dtsi
>>>
>>> diff --git a/arch/arm/boot/dts/imx6qdl-var-dart.dtsi b/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
>>> new file mode 100644
>>> index 0000000..fd2520b
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
>>> @@ -0,0 +1,504 @@
>>> +/*
>>> + * Support for Variscite DART-MX6 Module
>>> + *
>>> + * Copyright 2017 BayLibre, SAS
>>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>>> + *
>>> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> + */

Should this be instead on the first line with a // comment style if
possible, right?

>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Thomas has sent a first doc patch [1] set and is working on an updated
version.  Jonathan also wrote a nice background article on the topic
at LWN [2].

Linus explained why he wants the // comment style and a first line
location on the list too.

[1] https://marc.info/?l=linux-kernel&m=151051532322831&w=2
[2] https://lwn.net/SubscriberLink/739183/262749cbe307ddc7/

-- 
Cordially
Philippe Ombredanne
