From: zonque@gmail.com (Daniel Mack)
Date: Wed, 11 Dec 2013 15:10:39 +0100
Subject: [PATCH 0/8] Impedance matcher for Samsung boards
In-Reply-To: <005d01cef679$be770570$3b651050$%wilczek@samsung.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
 <52A865B1.9070908@gmail.com>
 <005d01cef679$be770570$3b651050$%wilczek@samsung.com>
Message-ID: <52A8725F.2020403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2013 03:03 PM, Piotr Wilczek wrote:
> Hi,
> 
>> -----Original Message----- From: Daniel Mack
>> [mailto:zonque at gmail.com] Sent: Wednesday, December 11, 2013 2:17
>> PM To: Piotr Wilczek; devicetree-discuss at lists.ozlabs.org;
>> linux-arm- kernel at lists.infradead.org Cc: Jason Cooper; Nicolas
>> Pitre Subject: Re: [PATCH 0/8] Impedance matcher for Samsung
>> boards
>> 
>> On 12/11/2013 02:07 PM, Piotr Wilczek wrote:
>>> This patchset implements the impedance-matcher for Samsung
>>> Exynos boards and does the following: - fix strncmp function; -
>>> ensure each DT blob is 4-byte aligned; - port 'atags_to_fdt' form
>>> Kernel; - add Exynos specific serial driver; - add support for
>>> Samsung boards, Trats and Trats2;
>>> 
>>> This patch set is based on: 
>>> https://github.com/zonque/pxa-impedance-matcher.git
>> 
>> Thanks for the patches!
>> 
>> I'm considering merging most of them, but I have my problems with
>> the inclusion of the libfdt library.
>> 
>> Could you explain what you need this for, exactly? Why can't you
>> just fix the device tree blob that you include instead of modifying
>> it at runtime?
> When bootloader needs to pass some information in ATAGS and
> CONFIG_ARM_APPENDED_DTB is turned off in kernel, then it has to be
> added to the device tree blob at runtime.

The question is: can't you just provide a dtb for each of your machines,
and distinguish them via their machine ID? Or do you really have
machines that come up with the same machine ID but differ in details
only stored in ATAGs?

After all, adding libfdt makes the code grow by more than factor 4.



Daniel
