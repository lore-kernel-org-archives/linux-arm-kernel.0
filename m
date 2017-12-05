From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 5 Dec 2017 15:28:25 +0800
Subject: [PATCH v2] sunxi-rsb: Include OF based modalias in device uevent
In-Reply-To: <20171128154734.v2yog6lwiombv3io@flea.home>
References: <53cb17f5-6077-419a-8e5c-6c80f9dfa9dc@rwthex-w2-a.rwth-ad.de>
 <20171128154734.v2yog6lwiombv3io@flea.home>
Message-ID: <CAGb2v67GF1JTDT9ip2OzycwN6euBu9QqLBLwkyUKD6D8Bs873Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 28, 2017 at 11:47 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Nov 27, 2017 at 08:05:34PM +0100, Stefan Br?ns wrote:
>> Include the OF-based modalias in the uevent sent when registering devices
>> on the sunxi RSB bus, so that user space has a chance to autoload the
>> kernel module for the device.
>>
>> Fixes a regression caused by commit 3f241bfa60bd ("arm64: allwinner: a64:
>> pine64: Use dcdc1 regulator for mmc0"). When the axp20x-rsb module for
>> the AXP803 PMIC is built as a module, it is not loaded and the system
>> ends up with an disfunctional MMC controller.
>>

Tags should be:

Fixes: d787dcdb9c8f ("bus: sunxi-rsb: Add driver for Allwinner Reduced
Serial Bus")
Cc: stable <stable@vger.kernel.org> # 4.4.x 7a3b7cd332db of: device:
Export of_device_{get_modalias, uvent_modalias} to modules

>> Cc: stable <stable@vger.kernel.org>
>> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Maxime, could you merge this as a fix to get it in fast?

ChenYu
