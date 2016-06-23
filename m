From: gxt@mprc.pku.edu.cn (Xuetao Guan)
Date: Thu, 23 Jun 2016 18:39:03 +0800 (CST)
Subject: [PATCH v3 4/4] ARM/PCI: remove arch specific
 pcibios_enable_device()
In-Reply-To: <20160622230746.GI25485@localhost>
References: <1465383890-13538-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1465383890-13538-5-git-send-email-lorenzo.pieralisi@arm.com>
 <20160622230746.GI25485@localhost>
Message-ID: <62140.117.114.135.40.1466678343.squirrel@mprc.pku.edu.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> [+cc Guan]
>
> On Wed, Jun 08, 2016 at 12:04:50PM +0100, Lorenzo Pieralisi wrote:
>> The arm pcibios_enable_device() implementation exists solely
>> to prevent enabling PCI resources on PCI_PROBE_ONLY systems, since
>> on those systems the PCI resources are currently not claimed (ie
>> inserted in the PCI resource tree - which means their parent
>> pointer is not correctly set-up) therefore they can not be enabled
>> since this would trigger PCI set-ups failures.
>>
>> After removing the pci=firmware command line option in:
>>
>> commit 903589ca7165 ("ARM: 8554/1: kernel: pci: remove pci=firmware
>> command line parameter handling")
>
> 903589ca7165 removed "pci=firmware" from ARM and from
> Documentation/kernel-parameters.txt (where it was documented as
> ARM-specific).
>
> I think unicore32 copied that code from arm, so unicore32 is one of
> the few remaining arches that can set PCI_PROBE_ONLY.  I suspect this
> was just copied from arm and may not be necessary on unicore32.
>
> Guan, can you confirm that PCI_PROBE_ONLY is necessary on unicore32,
> or that it can be removed?
>

Yes, this code was copied from arm, and it's not necessary.
It can be removed safely.

Guan Xuetao
