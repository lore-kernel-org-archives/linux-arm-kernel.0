From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 28 Feb 2017 17:21:18 +0100
Subject: usb/net/hso: WARNING: ungligned urb->setup_dma
In-Reply-To: <20170228120134.4f65yihw7x22hfwd@tarshish>
References: <20170228082810.syn656o2zzms7urf@tarshish>
 <20170228120134.4f65yihw7x22hfwd@tarshish>
Message-ID: <36230d64-4ba0-7515-1131-ecf3ab9f352c@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

Am 28.02.2017 um 13:01 schrieb Baruch Siach:
> Hi linux-usb list,
>
> (Dropped Jan's bouncing address, added Rpi3 platform lists)
>
> On Tue, Feb 28, 2017 at 10:28:10AM +0200, Baruch Siach wrote:
>> Hi linux-usb list,
>>
>> I'm hitting this warning consistently on my Raspberry Pi 3 running kernel
>> v4.10.1 with some unrelated device tree changes, and a debug print (below).
>> The device identifies as "GlobeTrotter HSDPA Modem", VID: 0af0, PID: 6971.
>> The warning triggers consistently on first write access to /dev/ttyHS0 that
>> ModemManager attempts. The first line in the log is my debug print.
> I tested the same hardware successfully on an i.MX6 CuBox-i (ARM32) using the
> same kernel version (4.10.1), and on an x86_64 PC (4.9). So this seems to be
> platform specific. I don't have any other ARM64 machine at the moment, though.

those platforms usually doesn't use the dwc2 USB host controller. So it 
should be tested with another dwc2 platform.

Is the issue reproducible with other USB devices like keyboards?
Are you using arm64 defconfig?
Are you able to bisect this issue?

Stefan
