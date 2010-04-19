From: therealbadguy@gmail.com (Badguy Badguy)
Date: Mon, 19 Apr 2010 13:40:50 -0600
Subject: iMX31 LogicPD LiteKit Kernel 2.6.33.2
In-Reply-To: <20100416083632.GF30801@buzzloop.caiaq.de>
References: <w2i3f34cd261004141302xdeb23378hfc4d795a6c9811c2@mail.gmail.com>
	<20100415075831.GL30801@buzzloop.caiaq.de>
	<i2i3f34cd261004151408ta09b0ca5lfe8bcd6289fb77ba@mail.gmail.com>
	<20100416083632.GF30801@buzzloop.caiaq.de>
Message-ID: <z2z3f34cd261004191240nce56a951jb24c4ce3c0c47503@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> so using the Hasan bootloader I provide:
>>
>> load raw 0x81000000 1073016 /tftp/192.168.1.161:zImage
> ? ? ? ? ? ? ? ? ? ? ?^^^^^^^
> This is the length of the kernel image, and I doubt this is right. Check
> the size of your zImage file again, it's almost certainly bigger than
> that.
>
> Daniel
>

Ok, well I think my problem was simply that I did not have the console
enabled! Oops!
and once I seen the LED light go solid, I figured it was locked.
(must not be being turned off)

I will mention that the serial port defaults to the 9600 baud implied
by the driver, this was also giving me trouble.
I note it attempts to read current state and use it, but must get it
wrong have not dug deeper yet, simply changed default to what the
bootloader is using 115200

I cleaned up my config some more, removed some redundant stuff got it
to boot to Oops from lack of FS support.
cannot get to the NFS server, digging into that.

Can I get a break down on how far you have run this kernel? Do you
have file system support?
I notice the NAND driver is throwing bad erase block warnings on a
large number of blocks, I will change SOM and see if it continues.

Exciting stuff! looking forward to helping move this forward as I get
the stuff I need working working, thanks a bunch for your help.
 -Chris
