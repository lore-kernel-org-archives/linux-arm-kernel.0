From: knut.wohlrab@de.bosch.com (Knut Wohlrab)
Date: Wed, 18 Jul 2012 16:11:25 +0200
Subject: Devicetree: Initialization order of mmc block devices?
In-Reply-To: <CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>
References: <5006571A.7060103@de.bosch.com>
 <CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
 <50068696.8070408@de.bosch.com>
 <CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>
Message-ID: <5006C40D.300@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2012 03:47 PM, Jassi Brar wrote:
> On 18 July 2012 15:19, Knut Wohlrab <knut.wohlrab@de.bosch.com> wrote:
>
>> If a SD card is inserted at boot time, its "mmcblk0", the embedded
>> MMC (eMMC) device "mmcblk1".  This makes it difficult to give the kernel the
>> correct device for the eMMC root file system ("root=/dev/mmcblk?p1 ...").
>>
> How about  root=UUID=<eMMC-partition>  ?
Because we are talking about an embedded device, it is very difficult to 
get a UUID of a eMMC partition into kernel command line with U-Boot. 
Handling of UUID is also a big effort at board manufacturing.

Startup speed is very important for us. Searching for UUID on several 
MMC/SD devices will significant slow down the boot process.

This problem can occur on many devices with embedded MMC and removable 
SD, e.g. smart phones. So I think we should find an solution to define 
MMC scan order or device number/name in a device tree.

Thanks and regards

Knut
