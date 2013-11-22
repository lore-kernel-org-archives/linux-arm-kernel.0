From: jonathan@jonmasters.org (Jon Masters)
Date: Thu, 21 Nov 2013 23:05:21 -0500
Subject: ACPI
In-Reply-To: <201311220129.54828.arnd@arndb.de>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <201311191915.57516.arnd@arndb.de> <20131121200344.GD14725@sirena.org.uk>
 <201311220129.54828.arnd@arndb.de>
Message-ID: <528ED801.8040705@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 11/21/2013 07:29 PM, Arnd Bergmann wrote:
> On Thursday 21 November 2013, Mark Brown wrote:
>> On Tue, Nov 19, 2013 at 07:15:57PM +0100, Arnd Bergmann wrote:
>>
>>> of them apply here. You keep saying "servers", but that isn't actually
>>> a feature of how the system is designed, rather than what is running
>>> on them. Given these examples (or any others, you could come up with),
>>> which ones do you actually see as relevant here:
>>
>>> 1. An exterprise server (SPARC enterprise M9000, Power 795, Integrity
>>>    Superdome) with the CPU core changed to run ARM instructions
>>> 2. An ATX whitebox server mainboard with one to four sockets and PC
>>>    peripherals and plug-compatible ARM CPU chips.
>>> 3. A purpose-built server SoC based on standard components
>>> 4. A new server SoC based on an older proprietary embedded or mobile
>>>    SoC design (think Exynos, OMAP, Snapdragon, ... based)
>>> 5. A server built from using a cheap devboard (BeagleBone, Cubieboard, ...
>>>    style) with an unmodified SoC.
>>> 6. A virtual machine running on KVM or Xen.

By 64-bit ARM server, I mean a system conformant with a series of
specifications that define what such a server system consists of. It
might be a physical system featuring an ARM-based SoC containing a core
conformant to the v8 Architecture, along with standardized peripherals,
or it might be a virtual platform. The boot architecture would include
UEFI (specifically a sequential progression from an initial EL3 reset
secure ROM on through to a verified Tiano build), and ACPI being used to
convey the platform devices, as well as for runtime event delivery.

>> I'd also ask if we need to consider desktops and laptops here - do we
>> really mean distros here rather than servers, even if servers are the
>> primary use case for distros right now?
> 
> Jon has previously said (multiple times) that he cares about servers
> only, so I assume that is still given. If you take the exact same
> hardware and firmware and add a PCIe GPU to turn it into a workstation
> or laptop, I don't see that change anything from the kernel perspective,
> but I'm trying to narrow the scope here, not widen it ;-)

I expect to see a series of useful announcements soon that will serve to
articulate what I am referring to by an ARM v8 server. I will followup
then with more thoughts about how this fits together.

Thanks,

Jon.
