From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 14 Apr 2016 11:07:54 +0200
Subject: [next] Failing Odroid XU3 boot due to missing MMC device
In-Reply-To: <20160414084530.GS19428@n2100.arm.linux.org.uk>
References: <570F5380.7010103@samsung.com> <570F5550.5010708@fivetechno.de>
 <20160414084530.GS19428@n2100.arm.linux.org.uk>
Message-ID: <570F5DEA.1060908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2016 10:45 AM, Russell King - ARM Linux wrote:
> On Thu, Apr 14, 2016 at 10:31:12AM +0200, Markus Reichl wrote:
>> Hi Krzysztof,
>>
>> yes, observed this with linux-next from yesterday 13.
>>
>> I boot from eMMC.
>> Device numbering of eMMC and SD are exchanged now.
>>
>> I solved the boot problem by changing the rootdev in U-Boot env
>> from /dev/mmcblk0p2 to /dev/mmcblk1p2.
>>
>> Changed /etc/fdisk, too, to mount /dev/mmcblk1p1 to /boot.     
> 
> You really should mount by partition uuid - supplying something like:
> 
> 	root=PARTUUID=f3ae567e-02
> 
> on the kernel command line.  This makes the mounting of rootfs
> independent of which device carries the filesystem.
> 
> If you're not using an initramfs, the kernel prints the partuuid
> values if it doesn't find the rootfs.  I don't know how to get the
> partuuids without going through that process, sorry.

Markus, Russell,

Thanks, I'll switch to UUID.

Best regards,
Krzysztof
