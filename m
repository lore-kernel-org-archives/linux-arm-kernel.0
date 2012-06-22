From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 22 Jun 2012 13:57:23 +0100
Subject: arm erratas (config options)
In-Reply-To: <20120622103512.GB19026@n2100.arm.linux.org.uk> (Russell King's
 message of "Fri, 22 Jun 2012 11:35:12 +0100")
References: <4FE44378.9050803@ahsoftware.de>
 <20120622103512.GB19026@n2100.arm.linux.org.uk>
Message-ID: <yw1xzk7va4i4.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, Jun 22, 2012 at 12:05:44PM +0200, Alexander Holler wrote:
>> E.g. /proc/cpuinfo talks about variant and revision while all the help  
>> texts for the erratas are talking about rNpM (which I would translate to  
>> "revision" and "patch level", without knowing the real meanings).
>
> rNpM is a hardware thing.  On the test chips which ARM Ltd supply on
> their platforms, it's marked on the case.  With SoC vendors, the only
> way to know this definitively is to ask them.

The N and M values are contained in the main ID register on any core
with a standard CP15 system control interface.  Occasionally, an
implementation will have incorrect values here, e.g. (some?) Samsung
Exynos4 chips, and don't ask me how that happens, but most of the time
these values are reliable.

The fields in /proc/cpuinfo are indeed populated from the ID register.
The raw value of the ID register is also printed to the kernel log early
on.

>> This makes it necessary to translate "variant" to 'r' and "revision" to  
>> 'p', which isn't really obvious (because most people would translate  
>> "revision" to 'r' and would wonder how to find the value for 'p' in  
>> /proc/cpuinfo or somewhere else).
>
> The variant and revision are terms used in the ARM ARM (or was used at
> some point) which don't always reflect the rNpM marking on the package.
> Sometimes, a hardware change is made which updates the rNpM but doesn't
> update the ID registers.  So they can't be relied upon.

The ARM ARM refers to the version fields in the main ID register as
"variant" and "revision" without assigning any specific meaning to
them beyond noting that "typically, [the variant] field distinguishes
between different product variants, or major revisions of a product."

The rNpM versioning scheme is commonly used by ARM, not only for CPU
cores.  The mapping of these versions to ID register fields is
unfortunately a little confusing, as you have noted.

-- 
M?ns Rullg?rd
mans at mansr.com
