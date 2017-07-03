From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 3 Jul 2017 23:22:45 +0300
Subject: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40B10487@FRAEML521-MBX.china.huawei.com>
References: <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
 <20170616120048.GC629@lahna.fi.intel.com>
 <CAJZ5v0g+qVui6RU=Hy3c_3qAAWngqaAu6B3JxGOpqF06kitbzA@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40ACFB8D@FRAEML521-MBX.china.huawei.com>
 <20170619100209.GC629@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40ACFC3D@FRAEML521-MBX.china.huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B10487@FRAEML521-MBX.china.huawei.com>
Message-ID: <CAHp75VevOno613gk8QHDA7kmLZJj9TLZRiu7oJUs_xaRzcbpnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 3, 2017 at 7:08 PM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:

JFYI: Mika on vacation.

> I had a look into the MFD framework. If my understanding is correct the mfd
> framework create a platform device for each declared mfd_cell that is passed
> to mfd_add_devices().

Right.

> However there is something that I do not quite understand:
> from
> http://elixir.free-electrons.com/linux/latest/source/drivers/mfd/mfd-core.c#L207
> it seems that mfd_add_device() will create the platform device using the
> resources that are statically declared in the respective mfd_cell.

It's one possibility.

> In my case I'd like to have a platform device using the resources that are
> parsed from the ACPI table (i.e. as it is done now by
> acpi_create_platform_device()).

So far so good. Nothing prevents you to do that.

> If my understanding is correct, if I declared an mfd_cell for my IPMI child
> the mfd subsystem would create a platform device for such child and
> therefore acpi_create_platform_device() would fail to create a new platform
> device as adev->physical_node_count will be non zero.
> However as things stand now mfd_cell devices can only use the resources
> that are statically defined in the code (and therefore not the ones in the
> ACPI nodes)...am I right?

You may file resources first and then register MFD cells. See many
existing examples in the kernel.

-- 
With Best Regards,
Andy Shevchenko
