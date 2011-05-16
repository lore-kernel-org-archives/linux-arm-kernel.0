From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Mon, 16 May 2011 11:36:28 +0530
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <201105151133.23870.arnd@arndb.de>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<201105142233.53659.arnd@arndb.de>
	<20110514221445.GB21792@opensource.wolfsonmicro.com>
	<201105151133.23870.arnd@arndb.de>
Message-ID: <B876E8072D52496DB747D5CCCF64826D@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!,

>> > My whole point has been that you register them from the main pruss 
>> > driver
>> > based on run-time data instead of compile-time pre-configured stuff in 
>> > the
>> > board file.
>>
>> I'm not so sure - if the usage is fixed as a result of the pins on the
>> device being wired a CAN bus then it seems reasonable to tell the system
>> about that so it'll stop the user trying to run SPI or something against
>> it at runtime.
>
> I'm mostly worried about the case where the pins are not hardwired for
> some specific function -- Subhasish was mentioning that these may be
> implemented using a pluggable extension board and I want to make sure
> that you are not required to recompile the kernel when changing the
> extension board.
>
> However, you made a good point that in many cases it will be hardwired
> so it may be valuable to preconfigure this in a way that does not require
> scripts to set up variables in sysfs when you already know what is there.
>
> Note that my suggestion to put the device name into the firmware file
> covers this case, because you can then simply ship a firmware blob that
> matches the hardware configuration. Thinking about the future device
> tree setup, you can even put the firmware blob itself into a property
> in the device tree file.
>

I earlier had an implementation where I used a pruss_devices structure
in the board file.

http://linux.omap.com/pipermail/davinci-linux-open-source/
2011-March/022339.html.

We can use this implementation along with the sysfs to load the devices
runtime. The configs that I have in the board_file for the devices 
structure,
are fixed for a board. To swap the boards, we do not need to re-compile
the kernel.

 
