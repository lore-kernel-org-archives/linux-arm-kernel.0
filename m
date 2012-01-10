From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 10 Jan 2012 11:09:05 +0100
Subject: [PATCH v2 09/10] arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
In-Reply-To: <CAOZdJXU9w1O69ZgNEmgUZfezXEyn1JTyZxgmmLXAb3-mtJLnOA@mail.gmail.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-10-git-send-email-b-cousson@ti.com>
 <CAOZdJXU9w1O69ZgNEmgUZfezXEyn1JTyZxgmmLXAb3-mtJLnOA@mail.gmail.com>
Message-ID: <4F0C0E41.1020405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/10/2012 12:24 AM, Tabi Timur-B04825 wrote:
> On Fri, Dec 9, 2011 at 8:02 AM, Benoit Cousson<b-cousson@ti.com>  wrote:
>>
>> +       eeprom at 50 {
>> +               compatible = "ti,eeprom";
>> +               reg =<0x50>;
>> +       };
>
> Why is this "ti,"?  For EDID, isn't the I2C device actually on the
> monitor itself, and DVI cable just connects to the I2C bus?

Yes, in fact I didn't know what to put here, since I do not know what 
kind of eeprom the monitor will use.

And then I realized that the i2c driver is using the compatible name 
without the prefix, so any prefix can be used there...
OK, that's maybe not a very valid reason... but I did not find any 
better prefix at that time:-)

> The reason I ask is that I'm trying to do the same thing for a PowerPC
> board.  I need to defined an EDID I2C node.

Well, this seems to be generic i2c eeprom, so maybe a "ddc," prefix or 
"edid," will be a little bit better.

If later, we want to access that node from the display driver, we can 
just add a phandle to the node's label: "edid-eeprom: eeprom at 50:"

Regards,
Benoit
