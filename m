From: marex@denx.de (Marek Vasut)
Date: Fri, 06 May 2016 18:27:47 +0200
Subject: [PATCH] ARM: at91: sama5: Update defconfig
In-Reply-To: <572CAA72.4000107@atmel.com>
References: <1462480295-8034-1-git-send-email-marex@denx.de>
 <572CAA72.4000107@atmel.com>
Message-ID: <572CC603.4000102@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2016 04:30 PM, Nicolas Ferre wrote:
> Le 05/05/2016 22:31, Marek Vasut a ?crit :
>> Enable CGROUPS support, so we can boot userspace that uses systemd on
>> top of kernel configured using this defconfig. The systemd userspace
>> depends on cgroups and without them, it dies in mysterious ways.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Hi Marek,

Hi!

> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> BTW, isn't it something else required to run a systemd enabled image?
> I've seen that some of the option may be missing as well:
> 
> CONFIG_FHANDLE (libudev, mount and bind mount handling)
> from: https://github.com/systemd/systemd/blob/master/README#L51

This one is absolutely mandatory, but this is also enabled by default
already. Debian testing with systemd won't boot without FHANDLE too,
so this is easy to trap for me.

> In the " Optional but strongly recommended:" I see interest in:
>  CONFIG_AUTOFS4_FS
>  CONFIG_TMPFS_XATTR
>  CONFIG_{TMPFS,EXT4,XFS,BTRFS_FS,...}_POSIX_ACL
> 
> But it's maybe not so interesting for our little embedded systems.

Hm, these are disabled, but I cannot comment on their significance.

> I'm also puzzled about the need for more options about cgroups...

Enabling CONFIG_CGROUPS is enough to make systemd happy and booting.
I didn't probe further, sorry.

> I add a couple of other people in Cc so we can figure out the proper
> configuration set...

Thanks!

> Thanks Marek for having started the discussion, bye,
> 
>> ---
>>  arch/arm/configs/sama5_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
>> index afbda41..1b60be2 100644
>> --- a/arch/arm/configs/sama5_defconfig
>> +++ b/arch/arm/configs/sama5_defconfig
>> @@ -3,6 +3,7 @@
>>  CONFIG_SYSVIPC=y
>>  CONFIG_IRQ_DOMAIN_DEBUG=y
>>  CONFIG_LOG_BUF_SHIFT=14
>> +CONFIG_CGROUPS=y
>>  CONFIG_BLK_DEV_INITRD=y
>>  CONFIG_EMBEDDED=y
>>  CONFIG_SLAB=y
>>
> 
> 


-- 
Best regards,
Marek Vasut
