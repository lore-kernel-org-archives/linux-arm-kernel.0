From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Fri, 9 Jan 2015 09:58:31 -0800
Subject: [PATCH] ARM: mm: fix PMD_SECT_RDONLY undeclared compile error
In-Reply-To: <20150109170002.GY12302@n2100.arm.linux.org.uk>
References: <1420653969-4048-1-git-send-email-victor.kamensky@linaro.org>
 <20150109170002.GY12302@n2100.arm.linux.org.uk>
Message-ID: <CAA3XUr2VpzVTq2mNMKT+MH9bkZQLkYpYZBWt23+aej4b6mFP5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2015 at 09:00, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 07, 2015 at 10:06:09AM -0800, Victor Kamensky wrote:
>> From: Victor Kamensky <kamensky@coreos-lnx2.cisco.com>
>>
>> In v3.19-rc3 tree when CONFIG_ARM_LPAE and CONFIG_DEBUG_RODATA are enabled
>> image failed to compile with the following error:
>>
>> arch/arm/mm/init.c:661:14: error: ?PMD_SECT_RDONLY? undeclared here (not in a function)
>>
>> It seems that '80d6b0c ARM: mm: allow text and rodata sections to be read-only'
>> and 'ded9477 ARM: 8109/1: mm: Modify pte_write and pmd_write logic for LPAE'
>> commits crossed. 80d6b0c uses PMD_SECT_RDONLY macro but ded9477 renames it
>> and uses software bits L_PMD_SECT_RDONLY instead.
>>
>> Fix is to use L_PMD_SECT_RDONLY instead PMD_SECT_RDONLY as ded9477 does in
>> another places.
>>
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>
> Please can you put it in the patch system with Will's ack if not
> already done, thanks.

Submitted as
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8275/1

Also fixed previously messed up Author field.

Thanks,
Victor

> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
