From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 11 Jun 2013 19:28:40 +0200
Subject: [PATCH 1/3] ARM: dts: Add headers with constants for MTD
 partitions
In-Reply-To: <51B74F2D.2080804@wwwdotorg.org>
References: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch>
 <1370962138-9631-2-git-send-email-florian.vaussard@epfl.ch>
 <51B74F2D.2080804@wwwdotorg.org>
Message-ID: <51B75E48.7060809@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

On 06/11/2013 06:24 PM, Stephen Warren wrote:
> On 06/11/2013 08:48 AM, Florian Vaussard wrote:
>> These constants can be used to easily declare MTD partitions inside
>> DTS.
>>
>> The constants MTDPART_OFS_* are purposely not included. Indeed,
>> parse_ofpart_partitions() is expecting u64, but a DT cell is u32.
>> Negative constants, as defined by MTDPART_OFS_*, would be wrongly
>> interpreted by parse_ofpart_partitions(). Two cells should be
>> used to correctly encode the negative constants, but this breaks
>> current usage.
>
> I think addition of common headers like this needs an ack from
> Grant/Rob. I CC'd them here.
>

Indeed. Thank you.

>> diff --git a/include/dt-bindings/mtd/partitions.h b/include/dt-bindings/mtd/partitions.h
>
>> + * This header provides constants used with MTD partitions.
> ...
>> +/* Partition size */
>> +#define MTDPART_SIZ_FULL	0
>
> Which binding document in Documentation/devicetree/bindings is this
> definition associated with? The comment above should really mention
> this. Documentation/devicetree/bindings/mtd/partition.txt doesn't seem
> to mention this value.
>

Mmmh I was not seeing this as a DT binding, strictly speaking. It was 
already
used with legacy board files. Otherwise we should also update the binding
for constants related to GPIO, IRQ,... But I agree that a line inside the
documentation never killed someone.

>> diff --git a/include/dt-bindings/sizes.h b/include/dt-bindings/sizes.h
>
> ...
>> +#define SZ_1G				0x40000000
>> +#define SZ_2G				0x80000000
>> +
>> +#endif
>
> For MTD partitions specifically, SZ_4G and onwards would be useful in
> theory, although that would end up putting two cell values into a single
> macro. and then the values couldn't be added/or'd together. So, I'm not
> really sure if we want to add those larger values, but food for thought...
>

It is maybe feasible to define a macro splitting the u64 into two
u32 cells? But this can be done afterwards when need arises.

Best regards,

Florian
