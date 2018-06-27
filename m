From: david@lechnology.com (David Lechner)
Date: Wed, 27 Jun 2018 12:13:02 -0500
Subject: [PATCH 2/2] ARM: davinci_all_defconfig: Enable Bluetooth
In-Reply-To: <5d45fabc-cc25-fbdf-859c-c29111b42eb2@ti.com>
References: <20180531202549.11255-1-david@lechnology.com>
 <20180531202549.11255-3-david@lechnology.com>
 <5d45fabc-cc25-fbdf-859c-c29111b42eb2@ti.com>
Message-ID: <0525829c-3070-6aee-39cf-1154dcbb1e75@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2018 06:11 AM, Sekhar Nori wrote:
> On Friday 01 June 2018 01:55 AM, David Lechner wrote:
>> This enables Bluetooth modules in davinic_all_defconfig needed for LEGO
> 
> davinci_all_defconfig
> 
>> MINDSTORMS EV3.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   arch/arm/configs/davinci_all_defconfig | 9 +++++++++
>>   1 file changed, 9 insertions(+)
> 
>> +CONFIG_SERIAL_DEV_BUS=y
> 
> Any reason to build this into the kernel?
> 

Yes:


config SERIAL_DEV_CTRL_TTYPORT
	bool "Serial device TTY port controller"
	help
	  Say Y here if you want to use the Serial device bus with common TTY
	  drivers (e.g. serial drivers).

	  If unsure, say Y.
	depends on TTY
	depends on SERIAL_DEV_BUS != m
	default y

endif
