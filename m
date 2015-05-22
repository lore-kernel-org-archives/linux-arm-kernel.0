From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 22 May 2015 17:09:47 +0530
Subject: [PATCH v2 1/2] phy: add lpc18xx usb otg phy driver
In-Reply-To: <CAGhQ9Vz+6s=SJXLu_5f-9aEjrT61aKnqnd=LitxZztdA-=NOiA@mail.gmail.com>
References: <1432223961-26101-1-git-send-email-manabian@gmail.com>	<1432223961-26101-2-git-send-email-manabian@gmail.com>	<555F109A.3030503@ti.com>	<CAGhQ9VxDNr5V+J4-7DU1EeOx3WDx7K2iea_6fXf-yowWq_wUYg@mail.gmail.com>
 <CAGhQ9Vz+6s=SJXLu_5f-9aEjrT61aKnqnd=LitxZztdA-=NOiA@mail.gmail.com>
Message-ID: <555F1583.9060005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 22 May 2015 05:08 PM, Joachim Eastwood wrote:
> On 22 May 2015 at 13:34, Joachim  Eastwood <manabian@gmail.com> wrote:
>> On 22 May 2015 at 13:18, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> Hi,
>>>
>>> On Thursday 21 May 2015 09:29 PM, Joachim Eastwood wrote:
>>>>
>>>> Add PHY driver for the internal USB OTG PHY found on NXP
>>>> LPC18xx and LPC43xx devices. This driver takes care of
>>>> enabling the PHY in CREG (syscon) and setting the required
>>>> clock frequency.
>>>>
>>>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>>>> ---
>>>>    drivers/phy/Kconfig               |  11 +++
>>>>    drivers/phy/Makefile              |   1 +
>>>>    drivers/phy/phy-lpc18xx-usb-otg.c | 143
>>>> ++++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 155 insertions(+)
>>>>    create mode 100644 drivers/phy/phy-lpc18xx-usb-otg.c
>>>>
>>>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>>>> index a53bd5b52df9..e11fb9e3c760 100644
>>>> --- a/drivers/phy/Kconfig
>>>> +++ b/drivers/phy/Kconfig
>>>> @@ -52,6 +52,17 @@ config PHY_EXYNOS_MIPI_VIDEO
>>>>            Support for MIPI CSI-2 and MIPI DSI DPHY found on Samsung S5P
>>>>            and EXYNOS SoCs.
>>>>
>>>> +config PHY_LPC18XX_USB_OTG
>>>> +       tristate "NXP LPC18xx/43xx SoC USB OTG PHY driver"
>>>> +       depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
>>>> +       select GENERIC_PHY
>>>> +       select MFD_SYSCON
>>>
>>>
>>> using select on visible symbols should be avoided. see [1]
>>>
>>> [1] ->
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/kbuild/kconfig-language.txt#n111
>>
>> For these two symbols using select is the right thing to do.
>>
>> Look at the users in kernel:
>> $ git grep -E 'depend (MFD_SYSCON|GENERIC_PHY)' | wc -l
>> 0
>> $ git grep -E 'select MFD_SYSCON' | wc -l
>> 42
>
> Sorry, screwed up the regex for depends.
>
> For depens we have:
> $ git grep -E 'depends on (MFD_SYSCON|GENERIC_PHY)' | wc -l
> 10

select for GENERIC_PHY is okay but I'd prefer to have depends on for MFD_SYSCON.

Thanks
Kishon
