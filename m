From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue, 5 Apr 2011 12:10:46 +0530
Subject: [PATCH v3 1/7] mfd: add pruss mfd driver.
In-Reply-To: <201103301259.28483.arnd@arndb.de>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<201103111628.57549.arnd@arndb.de>
	<17BF3847C06240EC921FB684D3120DEC@subhasishg>
	<201103301259.28483.arnd@arndb.de>
Message-ID: <34890DB1679E41119ADB156E2CFEC4C9@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Wednesday 30 March 2011, Subhasish Ghosh wrote:
>>
>> >> +s32 pruss_disable(struct device *dev, u8 pruss_num)
>> >> +{
>> >> + struct da8xx_pruss *pruss = dev_get_drvdata(dev->parent);
>> >> + struct da8xx_prusscore_regs *h_pruss;
>> >> + struct pruss_map *pruss_mmap = (struct pruss_map *)pruss->ioaddr;
>> >> + u32 temp_reg;
>> >> + u32 delay_cnt;
>> >
>> > Can you explain the significance of pruss_num? As far as I
>> > can tell, you always pass constants in here, so it should
>> > be possible to determine the number from the device.
>>
>> SG - The number is not programmed in the device, I need something to 
>> decide
>> which PRU to disable or enable.
>
> I still don't understand. Please explain how the devices
> relate to the multiple PRUs in hardware.

There are two devices, CAN and UART, in our case we use the PRU as follows:
1. CAN-TX on PRU0, CAN-RX on PRU1
2. SUART-TX on PRU0, SUART-RX on PRU1
3. SUART-TXRX on PRU0, SUART-TXRX on PRU1


 
