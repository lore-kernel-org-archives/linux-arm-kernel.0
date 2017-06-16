From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Fri, 16 Jun 2017 15:00:48 +0300
Subject: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
In-Reply-To: <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
References: <20170606085553.GA20085@red-moon> <20170612155700.GA31930@red-moon>
 <20170613084831.GP3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
Message-ID: <20170616120048.GC629@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 01:24:32PM +0200, Rafael J. Wysocki wrote:
> > In fact it may be that it is not sufficient in this case because the
> > ACPI core might enumerate child devices before the LPC driver even gets
> > a chance to probe so you would need to add also scan handler to the
> > child devices and mark them already enumerated or something like that.
> 
> Or extend the special I2C/SPI handling to them.

Sure but those have I2c/SpiSerialBus() resources which we can use to
identify them but for the ipmi thing there is nothing else than _HID so
we would need to keep a list of such devices in ACPI core.
