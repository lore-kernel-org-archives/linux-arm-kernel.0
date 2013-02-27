From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Feb 2013 08:00:08 -0600
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <22709540.96uJddbx1U@fb07-iapwap2.physik.uni-giessen.de>
References: <512BF81A.3080700@wwwdotorg.org>
 <4928288.ie8EUukfVD@fb07-iapwap2.physik.uni-giessen.de>
 <512CE533.6020005@wwwdotorg.org>
 <22709540.96uJddbx1U@fb07-iapwap2.physik.uni-giessen.de>
Message-ID: <512E1168.4080003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2013 03:03 AM, Marc Dietrich wrote:
> Am Dienstag, 26. Februar 2013, 09:39:15 schrieb Stephen Warren:
>> On 02/26/2013 02:36 AM, Marc Dietrich wrote:
>>> Am Montag, 25. Februar 2013, 16:47:38 schrieb Stephen Warren:
>>>> ...
>>>> Now, I can easily add those 3 errata workarounds to U-Boot, but that
>>>> will require people to reflash their bootloader. This is probably
>>>> acceptable for development/reference boards (although I'm sure people
>>>> will find it annoying) but for re-purposed production boards (such as
>>>> the Toshiba AC100 or various tablets) it will be impossible to update
>>>> the factory bootloader. Switching to upstream U-Boot would currently
>>>> lose some functionality, and significantly affect people's boot flow, so
>>>> is likely unacceptable.
>>>
>>> personally, I have no problem to require a certain u-boot version for a
>>> given kernel. From a distro point of view, you will likely update the
>>> bootloader/kernel on a distro update anyway.
>>
>> So a distro will certainly update the kernel.
>>
>> But updating a bootloader would be very unusual, I believe.
> 
> mmh? Every time I update to a new distro release, the bootloader gets also 
> updated - even on arm, e.g. ftp://ports.ubuntu.com/ubuntu-ports/pool/main/u/u-boot-linaro lists four version of uboot - one for each supported distro 
> release. I know for closed embedded device this is different, but that's not 
> our target.

There is a package of u-boot bootloaders, but they are not installed by
the OS. On ubuntu, installing a kernel only writes the boot.scr script.
There is an assumption that u-boot will go and read this. So we already
have some requirements on u-boot which would require at least a u-boot
environment update. I guess updating the environment is easier than
u-boot itself, but that probably depends on the platform.

Rob
