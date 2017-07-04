From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 4 Jul 2017 16:22:11 +0000
Subject: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
 devices before scanning
In-Reply-To: <CAHp75VccwpesvDxMcxZ+349rhrAq8QxNoau9XmquMnv9DBLBfA@mail.gmail.com>
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
 <CAHp75VevOno613gk8QHDA7kmLZJj9TLZRiu7oJUs_xaRzcbpnw@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B15AA2@FRAEML521-MBX.china.huawei.com>
 <CAHp75VccwpesvDxMcxZ+349rhrAq8QxNoau9XmquMnv9DBLBfA@mail.gmail.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B16310@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy

[...]

> 
> You may do it on stack. Define your cell statically (but not const)
> and apply resources just before mfd_add_devices() call.

Ok thanks got it

> There are examples in the existing drivers. Intel LPC comes to my mind
> and perhaps PMC (Broxton), though latter has too much other stuff
> around.

Uh yes I see now in lpc_ich.c (base address is read from PCI config space
and resources are set accordingly).

Cheers
Gab

> 
> --
> With Best Regards,
> Andy Shevchenko
