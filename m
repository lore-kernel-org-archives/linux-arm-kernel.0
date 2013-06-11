From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 11 Jun 2013 10:09:17 +0530
Subject: [PATCH 00/11] Convert GPIO Davinci to platform driver
In-Reply-To: <518397C60809E147AF5323E0420B992E3EAD887C@DBDE04.ent.ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
 <51B1958C.3050704@ti.com>
 <518397C60809E147AF5323E0420B992E3EAD887C@DBDE04.ent.ti.com>
Message-ID: <51B6A9F5.5020300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 6/10/2013 2:32 PM, Philip, Avinash wrote:
> On Fri, Jun 07, 2013 at 13:40:52, Nori, Sekhar wrote:
>> Hi Avinash,
>>
>> On 5/22/2013 12:40 PM, Philip Avinash wrote:
>>> GPIO Davinci driver converted to platform driver to support DT booting.
>>> In this patch series
>>> - Cleaned gpio Davinci driver code with proper commenting style and appropriate
>>>   variable names.
>>> - Create platform driver for GPIO Davinci in da8xx and dm* platforms and removed
>>>   gpio related member updation in davinci_soc_info structure.
>>> - DT support added for da850 board and tested on da850 EVM.
>>> - Remove soc_info reference in the gpio davinci driver and start uses
>>>   gpiolib interface.
>>
>> Can you please document which platforms this series was tested on and how?
> 
> This series being tested on da850 EVM. Tested by setting VPIF_DOUT[12] as GPIO
> pin [2] and reading GPIO status from GPIO[7,4]
> 
> GPIO[7,4] will reflect the status switch number 8 of the S7 dip switch in DA850 EVM.
> 
> Testing Procedure
> 
> Requirement GPIO SYSFS support [1]
> 
> #echo 116 > /sys/class/gpio/export
> setting GPIO[7,4] as input GPIO
> #echo "in" > /sys/class/gpio/gpio116/direction
> #mount -t debugfs debugfs /sys/kernel/debug
> Reading GPIO pin status
> #cat /sys/kernel/debug/gpio
> #echo 116 > /sys/class/gpio/unexport
> 
> 
> 1. Enable GPIO SYSFS support through menconfig
> --- GPIO Support
> 	[ ]   Debug GPIO calls
>                [ ]   /sys/class/gpio/... (sysfs interface)
>  
> 2. Patch for pinmux support for GPIO[7,4] is available at
> https://github.com/avinashphilip/am335x_linux/commits/linux_davinci_v3.10_soc_gpio

Can you check interrupt generation too since there are significant
changes in that area? You can generate an interrupt using the MMC/SD
card detect pin (inserting an MMC/SD card into the slot should generate
an interrupt). You can also write a new value to any GPIO pin. That will
also trigger an interrupt.

It will be nice if you can test this series on DM365 as well (read/write
as well as interrupt).

Thanks,
Sekhar
