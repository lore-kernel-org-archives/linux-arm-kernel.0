From: crosthwaitepeter@gmail.com (Peter Crosthwaite)
Date: Sun, 29 Nov 2015 14:56:53 -0800
Subject: Adding VIRTIO to the multi_v7_defconfig
In-Reply-To: <2788112.C4O6ljO5dG@wuerfel>
References: <CAPokK=rMi0OuqwePNkWMEi+5f_GZzw-j8fkN__2docvzwGV5+A@mail.gmail.com>
 <2788112.C4O6ljO5dG@wuerfel>
Message-ID: <CAPokK=rj4dDfMAF16RhY8pnnXrmddtnTyOOB__Eek0GhsC5XeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 29, 2015 at 2:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 29 November 2015 14:18:24 Peter Crosthwaite wrote:
>>
>> I started a small project to test as many QEMU emulated ARM boards
>> using the multi_v7 defconfig:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg00755.html
>>
>> One thing that came up was we cannot use the virt board as it relies
>> on virtio hotplug and drivers to get block and network support. The
>> defconfig is missing the drivers. Should we add the VIRTIO drivers to
>> the defconfig to bring this into play?
>
> Yes, please send a patch, this is definitely useful. We normally ask
> everyone to use loadable modules for newly enabled device drivers
> in multi_v7_defconfig, but we might actually use built-in drivers
> here if that would otherwise be the only module needed for booting.
>

So minimally I am looking for:

CONFIG_VIRTIO_PCI=y"
CONFIG_VIRTIO_BLK=y"
CONFIG_VIRTIO_NET=y"

As that gets you booted with network without needing initrd. I guess
the rest of VIRTIO makes more sense as modules as follow up work?

Regards,
Peter

>         Arnd
