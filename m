From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 20 Dec 2013 13:26:17 -0700
Subject: [PATCH] ARM: multi_v7: copy most options from tegra_defconfig
In-Reply-To: <CAOesGMh4PkdTh8EP1WS9-_5cVe1NWuNQPbkskk7hJhtbBEPWBg@mail.gmail.com>
References: <1387569848-16563-1-git-send-email-swarren@wwwdotorg.org>
 <CAOesGMh4PkdTh8EP1WS9-_5cVe1NWuNQPbkskk7hJhtbBEPWBg@mail.gmail.com>
Message-ID: <52B4A7E9.9090900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2013 01:16 PM, Olof Johansson wrote:
> On Fri, Dec 20, 2013 at 12:04 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

>> +CONFIG_EXT2_FS=y
>> +CONFIG_EXT2_FS_XATTR=y
>> +CONFIG_EXT2_FS_POSIX_ACL=y
>> +CONFIG_EXT2_FS_SECURITY=y
>> +CONFIG_EXT3_FS=y
>> +CONFIG_EXT3_FS_POSIX_ACL=y
>> +CONFIG_EXT3_FS_SECURITY=y
> 
> I think it makes sense to just enable EXT4_USE_FOR_EXT23 instead.

It looks like that's the default if EXT2_FS/EXT3_FS aren't enabled. I'll
go test that out.

>>  CONFIG_EXT4_FS=y
>> +CONFIG_VFAT_FS=y
>>  CONFIG_TMPFS=y
>> +CONFIG_SQUASHFS=y
>> +CONFIG_SQUASHFS_LZO=y
>> +CONFIG_SQUASHFS_XZ=y
>>  CONFIG_NFS_FS=y
>>  CONFIG_NFS_V3_ACL=y
>>  CONFIG_NFS_V4=y
>>  CONFIG_ROOT_NFS=y
>>  CONFIG_PRINTK_TIME=y
>>  CONFIG_DEBUG_FS=y
>> -CONFIG_DEBUG_KERNEL=y
> 
> Why are you disabling DEBUG_KERNEL?

It's not disabled, it ends up getting selected by something else, so
doesn't appear in the defconfig.
