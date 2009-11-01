From: swetland@google.com (Brian Swetland)
Date: Sun, 1 Nov 2009 15:33:39 -0800
Subject: [3/3,ARM] msm: add minimal board file for HTC Dream device
In-Reply-To: <20091101231950.GF20740@elf.ucw.cz>
References: <20091101221345.GA16926@elf.ucw.cz>
	<a55d774e0911011501x6abdb6a2p117f7038a4fa80cf@mail.gmail.com>
	<20091101231950.GF20740@elf.ucw.cz>
Message-ID: <a55d774e0911011533xf9b1285k7dc92745f2fb4edf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 1, 2009 at 3:19 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>
>> Pretty sure it's something later than .29
>
> I guess I should try 2.6.31.
>
>> Does enabling DEBUG_LL help? ?If something's dying before the serial
>> port is registered, you might never see any console chatter.
>
> DEBUG_LL does not help. Is that early_printk() equivalent?
> With DEBUG_ICEDC I don't even get "uncompressing linux" message.

ICEDCC will try to send messages to JTAG DCC.

Sticking a call to printascii(printk_buf) after the vscnprintf() in
vprintk() in kernel/printk.c is sometimes useful alongside DEBUG_LL
(so that printks will go to the serial port immediately).

> Yes, I believe it dies before serial registration :-(. Being able to
> call puts() that decompressor uses would be useful...
>
>> Also, I believe you'll want to pass console=ttyMSM2,115200n8 on the
>> kernel commandline ?(-c parameter to fastboot or mkbootimg).
>
> I'm using "console=ttyMSM2 rootdelay=5 fbcon=rotate:1" that worked for
> me on another kernel version...
>
