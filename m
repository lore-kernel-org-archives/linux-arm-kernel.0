From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 19 Apr 2017 20:44:09 -0500
Subject: [GIT PULL] ARM: SOC PM domain for 4.12
In-Reply-To: <0358ac18-8d7a-84a6-356f-8c9e8840bc4d@oracle.com>
References: <1491500546-6873-1-git-send-email-ssantosh@kernel.org>
 <CAK8P3a0jtLFgzB-u1Prhn1AvPH3OzLZ=uc--YP4fo9-7irikag@mail.gmail.com>
 <0358ac18-8d7a-84a6-356f-8c9e8840bc4d@oracle.com>
Message-ID: <58F81269.70207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,
On 04/19/2017 05:54 PM, santosh.shilimkar at oracle.com wrote:
> +Dave,
> 
> On 4/19/17 12:56 PM, Arnd Bergmann wrote:
>> On Thu, Apr 6, 2017 at 7:42 PM, Santosh Shilimkar <ssantosh@kernel.org> wrote:
>>> Hi Arnd, Olof,
>>>
>>> As inidcated on the list, because of various dependencies, am senidng
>>> Dave Gerlach's full patchset in single pull request.
>>>
>>> The following changes since commit 4495c08e84729385774601b5146d51d9e5849f81:
>>>
>>>   Linux 4.11-rc2 (2017-03-12 14:47:08 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
>>> tags/arm-soc-pmdomain
>>>
>>> for you to fetch changes up to ae3874cc931b760c08bd6617a45fec1ba97d87f8:
>>>
>>>   ARM: keystone: Drop PM domain support for k2g (2017-04-04 08:59:28 -0700)
>>>
>>> ----------------------------------------------------------------
>>> ARM SOC PM domain support for 4.12
>>>
>>> Dave Gerlach (5):
>>>       PM / Domains: Add generic data pointer to genpd data struct
>>>       PM / Domains: Do not check if simple providers have phandle cells
>>>       dt-bindings: Add TI SCI PM Domains
>>>       soc: ti: Add ti_sci_pm_domains driver
>>>       ARM: keystone: Drop PM domain support for k2g
>>
>> I went through the list of arm at kernel.org emails that had not seen a reply after
>> Olof's pull marathon today. I did not get a reply for this one, but I
>> see that Olof
>> has merged it into next/drivers.
>>
> Thanks.
> 
>> Since I was looking at it, I also took a closer look at the contents of the
>> patch series. The driver itself looks fine, but for the record, I'm not that
>> happy about seeing a header file duplicating the information from the
>> data sheet: We only use dt-binding headers to establish an interface between
>> the driver and the sources when there is well-defined fixed way to enumerate
>> resources, but in this case there clearly is...
>>

I apologize but I'm not clear on exactly what your concern is? Currently we
define a device ID which is associated to a "device" in the firmware's view of
the world, however the firmware has no knowledge of what goes on in the kernel
and vice-versa. The device ID is associated to that device only on that
hardware, it could be a different ID on a different SoC making use of SCI. The
only way a device is identified to the firmware is through this number, it will
also be used by the ti-sci-clock [1] and ti-sci-reset [2] drivers to identify
the device.

I'm not sure what you mean by "We only use dt-binding headers to establish an
interface between the driver and the sources when there is well-defined fixed
way to enumerate resources."

Regards,
Dave

[1] https://www.spinics.net/lists/arm-kernel/msg537665.html
[2] https://www.spinics.net/lists/devicetree/msg151643.html

> Dave, please care to follow up Arnd's concerns on those defines.
> 
> Regards,
> Santosh
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
