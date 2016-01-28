From: rogershimizu@gmail.com (Roger Shimizu)
Date: Thu, 28 Jan 2016 22:45:06 +0900
Subject: [PATCH] ARM: dts: orion5x: add mtd flash support to linkstation
 lswtgl
In-Reply-To: <CAEQ9gEmcss4sb6hE6-w0jVoYfHqnWNf23EVNMefvZ24TYfEk2g@mail.gmail.com>
References: <1453907405-30434-1-git-send-email-rogershimizu@gmail.com>
 <20160127173231.GI20194@lunn.ch>
 <CAEQ9gEmcss4sb6hE6-w0jVoYfHqnWNf23EVNMefvZ24TYfEk2g@mail.gmail.com>
Message-ID: <CAEQ9gEkU8x80-S=n+e8NBfN7OTSxHLdBSN_3q6d0JxZDxfs_9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew,

On Thu, Jan 28, 2016 at 3:22 AM, Roger Shimizu <rogershimizu@gmail.com> wrote:
> On Thu, Jan 28, 2016 at 2:32 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> Same comment i just sent to Thomas:
>>
>> The partition table should be a subnode of the mtd node and should be named
>> 'partitions'. This node should have the following property:
>> - compatible : (required) must be "fixed-partitions"
>> Partitions are then defined in subnodes of the partitions node.
>>
>> For backwards compatibility partitions as direct subnodes of the mtd device are
>> supported. This use is discouraged.
>>
>>            Andrew
>
> Thanks for your comments!
>
> Using the patch I submitted result in:
>
> [    1.667440] Found: SST 39LF020
> [    1.670613] f4000000.flash: Found 1 x8 devices at 0x0 in 8-bit bank
> [    1.676948] number of JEDEC chips: 1
> [    1.698943] 3 ofpart partitions found on MTD device f4000000.flash
> [    1.705222] Creating 3 MTD partitions on "f4000000.flash":
> [    1.710803] 0x000000000000-0x000000030000 : "header"
> [    1.719051] 0x000000030000-0x00000003f000 : "uboot"
> [    1.727182] 0x00000003f000-0x000000040000 : "uboot_env"
>
> Applying the partition DT proposed in
> Documentation/devicetree/bindings/mtd/partition.txt, result in:
>
> [    1.667879] Found: SST 39LF020
> [    1.671053] f4000000.flash: Found 1 x8 devices at 0x0 in 8-bit bank
> [    1.677389] number of JEDEC chips: 1
>
> So the partitions are gone.

Now I'm thinking for my dts's case, which is orion5x, refer
- Documentation/devicetree/bindings/mtd/mtd-physmap.txt
- Documentation/devicetree/bindings/mtd/orion-nand.txt
would be more proper.
And in the sample of mtd-physmap.txt, the structure described in
partition.txt is not mentioned.

Could we go as the dts is, like the original patch I submitted?

Cheers,
Roger
