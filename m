From: john.garry@huawei.com (John Garry)
Date: Thu, 29 Jun 2017 17:16:15 +0100
Subject: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
In-Reply-To: <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
References: <20170530132408.GA2556@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E40A7B677@FRAEML521-MBX.china.huawei.com>
 <20170606085553.GA20085@red-moon> <20170612155700.GA31930@red-moon>
 <20170613084831.GP3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
Message-ID: <808a7db0-7844-b263-0216-1fe943ac819a@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/06/2017 12:24, Rafael J. Wysocki wrote:
>>>> >> >
>>>> >> > It causes acpi_default_enumeration() to be called but it should be fine
>>>> >> > as we are dealing with platform device anyway.
>>> >>
>>> >> I do not quite understand how declaring such MFD cell above would make sure
>>> >> that the LPC probe is called before the IPMI device is enumerated...
>> >
>> > In fact it may be that it is not sufficient in this case because the
>> > ACPI core might enumerate child devices before the LPC driver even gets
>> > a chance to probe so you would need to add also scan handler to the
>> > child devices and mark them already enumerated or something like that.
> Or extend the special I2C/SPI handling to them.
>

For this, is it possible to just configure the ACPI table so we spoof 
that the LPC slave (IPI0001), is an i2c/spi slave? Could we just add a 
resource of type ACPI_RESOURCE_TYPE_SERIAL_BUS, and common serial bus 
type i2c/spi to solve this?

This resource would/should need to be ignored for other purposes.

John

> Thanks,
> Rafael
