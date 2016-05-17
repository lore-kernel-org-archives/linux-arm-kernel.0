From: jcm@redhat.com (Jon Masters)
Date: Tue, 17 May 2016 12:48:53 -0400
Subject: [PATCH 3/3] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
In-Reply-To: <f0bf43ef-0be5-484c-5066-ab1929105b82@redhat.com>
References: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
 <1463486765-31827-4-git-send-email-aleksey.makarov@linaro.org>
 <20160517124629.GE14955@leverpostej>
 <f0bf43ef-0be5-484c-5066-ab1929105b82@redhat.com>
Message-ID: <b0933a59-239d-536f-4f63-a65e469f62a1@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2016 12:44 PM, Jon Masters wrote:

> 1). During development of a platform, it is much easier to debug
> problems with tables if you can test replacement ones without having to
> respin the firmware. In the server world, you usually don't have the
> firmware source code, so to get it respun could be days-weeks even if
> you are working with the authors closely. We have practically used this
> feature on a number of platforms already and it will continue.

For example, on one platform we were unable to fully boot RHEL(SA) due
to a bug in one of the ACPI tables. But I was able to boot the system to
a ramdisk containing a uuencode library and then write out the content
of the tables over the serial port, then decompile/patch/recompile, and
override replacement tables on the system. Then we beat the vendor up
with the fixes and the official firmware was corrected.


-- 
Computer Architect | Sent from my Fedora powered laptop
