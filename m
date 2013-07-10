From: tibor@harsszegi.com (Tibor Harsszegi)
Date: Wed, 10 Jul 2013 19:13:48 +0200
Subject: NSA310 + DT
In-Reply-To: <51DD926C.1010205@harsszegi.com>
References: <51DC564A.8050002@harsszegi.com> <20130709193605.GC26223@lunn.ch>
 <20130709202143.GD26223@lunn.ch>
 <2544f179ed4349545a25aa60d52a664a@harsszegi.com>
 <20130710134119.GA30885@lunn.ch> <51DD8E8B.2040505@harsszegi.com>
 <20130710165342.GA31692@lunn.ch> <51DD926C.1010205@harsszegi.com>
Message-ID: <51DD964C.7020200@harsszegi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WTF. Andrew. It works COMPLETELY.
The memory mapped GPIO was working from the .config (don't ask me how).

* sensors
* LEDs
* bootup works

Awesome work thanks a lot!!!!
> Cool, keep you posted.
>> On Wed, Jul 10, 2013 at 06:40:43PM +0200, Tibor Harsszegi wrote:
>>> Hello Andrew,
>>>
>>> I did a:
>>>
>>> ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make clean
>>> ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make kirkwood_defconfig
>>> ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make zImage
>>> ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make dtbs
>>> cat arch/arm/boot/zImage arch/arm/boot/dts/kirkwood-nsa310-tdc.dtb > 
>>> /tmp/X
>>> mv /tmp/X arch/arm/boot/zImage
>>> ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make uImage
>>> ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make modules
>>>
>>> [attached .config]
>>>
>>> copied the uImage over the NSA310, rebooted.
>>> Good news: console is back
>> Great. Probably was OF_SERIAL_PLATFORM
>>
>>> Bad news: LEDs still don't work (all green), kernel stops (tried
>>> forcing rootfstype=ext4, didn't help)
>> Ah, O.k. EXT4 is not part of kirkwood_defconfig. Hence it cannot mount
>> the root fs.
>>
>> Please could you use make menuconfig and include it into the kernel
>> image. I will also update the patch later.
>>
>> LEDs are not working because the GPIO driver is not loading.
>> I will see if i can spot an obvious typo etc.
>>
>>    Andrew
>
