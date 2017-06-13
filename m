From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Tue, 13 Jun 2017 11:48:31 +0300
Subject: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
In-Reply-To: <20170612155700.GA31930@red-moon>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495712248-5232-6-git-send-email-gabriele.paoloni@huawei.com>
 <20170530132408.GA2556@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E40A7B677@FRAEML521-MBX.china.huawei.com>
 <20170606085553.GA20085@red-moon> <20170612155700.GA31930@red-moon>
Message-ID: <20170613084831.GP3187@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 04:57:00PM +0100, Lorenzo Pieralisi wrote:
> I had a more in-depth look at this series and from my understanding
> the problem are the following to manage the LPC bindings in ACPI.
> 
> (1) Child devices of an LPC controller require special handling when
>     filling their resources (ie they need to be translated - in DT
>     that's guaranteed by the "isa" binding, in ACPI it has to be
>     done by new code)
> (2) In DT systems, LPC child devices are created by the LPC bus
>     controller driver through an of_platform_populate() call with
>     the LPC controller node as the fwnode root. For ACPI to work
>     the same way there must be a way to prevent LPC children to
>     be enumerated in acpi_default_enumeration() something like
>     I2C does (and then the LPC driver would enumerate its children as
>     DT does)
> 
> I am not sure how (1) and (2) can be managed with current ACPI bindings
> and kernel code - I suspect it may be done by mirroring what's done
> for I2C but I am not sure, that's why I CC'ed Mika (ie the LPC adapter
> is matched as a platform device and it takes care of enumerating its
> children - problem though is preventing enumeration from core ACPI code).

Is there an example ASL showing how these LPC devices are
currently presented in ACPI?
