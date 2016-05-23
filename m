From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 23 May 2016 18:56:32 +0100
Subject: [PATCH 3/3] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
In-Reply-To: <b0933a59-239d-536f-4f63-a65e469f62a1@redhat.com>
References: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
 <1463486765-31827-4-git-send-email-aleksey.makarov@linaro.org>
 <20160517124629.GE14955@leverpostej>
 <f0bf43ef-0be5-484c-5066-ab1929105b82@redhat.com>
 <b0933a59-239d-536f-4f63-a65e469f62a1@redhat.com>
Message-ID: <20160523175632.GA16456@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 12:48:53PM -0400, Jon Masters wrote:
> On 05/17/2016 12:44 PM, Jon Masters wrote:
> 
> > 1). During development of a platform, it is much easier to debug
> > problems with tables if you can test replacement ones without having to
> > respin the firmware. In the server world, you usually don't have the
> > firmware source code, so to get it respun could be days-weeks even if
> > you are working with the authors closely. We have practically used this
> > feature on a number of platforms already and it will continue.
> 
> For example, on one platform we were unable to fully boot RHEL(SA) due
> to a bug in one of the ACPI tables. But I was able to boot the system to
> a ramdisk containing a uuencode library and then write out the content
> of the tables over the serial port, then decompile/patch/recompile, and
> override replacement tables on the system. Then we beat the vendor up
> with the fixes and the official firmware was corrected.

Can you explain to me please why you can't do it with GRUB ?

I am using mainline GRUB and its acpi command all the time to update
static ACPI tables for testing new features (ie IORT) and it works
just fine for me (and you can still override the DSDT, which is
likely to be the main source of bugs, through the CONFIG_ACPI_CUSTOM_DSDT
config option, that works on ARM in mainline with no changes required).

I just want to understand if there is really a compelling reason
for adding this stuff when we can easily implement its features
through something that is usable today without any kernel changes.

Thanks,
Lorenzo
