From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Dec 2016 11:08:03 -0800
Subject: [PATCH v3 2/2] FPGA: Add TS-7300 FPGA manager
In-Reply-To: <SN1PR0101MB1565A30EFE8AFEB319B84124D09A0@SN1PR0101MB1565.prod.exchangelabs.com>
References: <20161214023553.9377-1-f.fainelli@gmail.com>
 <20161214023553.9377-3-f.fainelli@gmail.com>
 <CAAtXAHe6q2jRWXt+KUWCFnP5j21E3x=P+4wjZTOaSSB_pX71Eg@mail.gmail.com>
 <cf772070-73d9-fa07-b2b9-e0038832b7be@gmail.com>
 <SN1PR0101MB1565A30EFE8AFEB319B84124D09A0@SN1PR0101MB1565.prod.exchangelabs.com>
Message-ID: <a8973dbf-0053-f44d-05f2-b787317db765@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2016 10:58 AM, Hartley Sweeten wrote:
> On Wednesday, December 14, 2016 11:55 AM, Florian Fainelli wrote:
>> My understanding is that, yes, this triggers the final write. You are
>> right that ts73xx_fpga_write() can be called multiple times. It sounds
>> like what my write_complete function does right now is just return that
>> we successfully completed the bistream write, but this snippet that you
>> are quoting should actually be moved into write_complete.
> 
> Florian,
> 
> I'm in the process of getting a TS-7300 board so I can help test this. Hopefully
> I will have it by next week.

Great! I got a few things on my list that have not been submitted yet:

- tmp124 support through drivers/hwmon/lm70.c
- specific memcpy_{from,to}io accessors for ethoc from the FPGA
- serial port support for the UARTs from the FPGA

And some other things that are giving me issues at the moment, like
SPI_3WIRE support for spi-ep93xx so I can configure the tmp124 to send
alarms/have temperature thresholds.

My branch is here:

https://github.com/ffainelli/linux/tree/ts72xx

Cheers
-- 
Florian
