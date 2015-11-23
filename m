From: jlinton@redhat.com (Jeremy Linton)
Date: Mon, 23 Nov 2015 12:46:05 -0600
Subject: [PATCH] [PATCH] arm64: Boot failure on m400 with new cont PTEs
In-Reply-To: <5653524B.40302@labbott.name>
References: <1447858999-26665-1-git-send-email-jeremy.linton@arm.com>
 <20151118152044.GD10644@leverpostej> <564CA29A.9050905@arm.com>
 <20151118162932.GA13355@leverpostej>
 <20151123155132.GC32300@e104818-lin.cambridge.arm.com>
 <5653387A.2000101@redhat.com> <565340C9.7010605@labbott.name>
 <56534212.3000302@redhat.com> <5653524B.40302@labbott.name>
Message-ID: <56535EED.5040401@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2015 11:52 AM, Laura Abbott wrote:
> On 11/23/15 8:42 AM, Jeremy Linton wrote:
>> On 11/23/2015 10:37 AM, Laura Abbott wrote:
>>> Which permissions still need to be cleaned up from your perspective?
>>
>> IMHO, the vast majority of the linear map should not be
>> executable/read/write, which is what happens today.
>>
>
> With CONFIG_DEBUG_RODATA on I'm not seeing any rwx regions

> 0xffffffc000000000-0xffffffc000080000         512K     RW NX SHD AF
> CON     UXN MEM/NORMAL
> 0xffffffc000080000-0xffffffc000082000           8K     RW NX SHD
> AF            UXN MEM/NORMAL
> 0xffffffc000082000-0xffffffc000090000          56K     ro x  SHD
> AF            UXN MEM/NORMAL
> 0xffffffc000090000-0xffffffc000200000        1472K     ro x  SHD AF
> CON     UXN MEM/NORMAL
> 0xffffffc000200000-0xffffffc000800000           6M     ro x  SHD
> AF        BLK UXN MEM/NORMAL
> 0xffffffc000800000-0xffffffc000980000        1536K     ro x  SHD AF
> CON     UXN MEM/NORMAL
> 0xffffffc000980000-0xffffffc000987000          28K     ro x  SHD
> AF            UXN MEM/NORMAL
> 0xffffffc000987000-0xffffffc000990000          36K     RW NX SHD
> AF            UXN MEM/NORMAL
> 0xffffffc000990000-0xffffffc000a00000         448K     RW NX SHD AF
> CON     UXN MEM/NORMAL
> 0xffffffc000a00000-0xffffffc000a10000          64K     RW NX SHD
> AF            UXN MEM/NORMAL
> 0xffffffc000a10000-0xffffffc000c00000        1984K     RW NX SHD AF
> CON     UXN MEM/NORMAL
> 0xffffffc000c00000-0xffffffc040000000        1012M     RW NX SHD
> AF        BLK UXN MEM/NORMAL
> 0xffffffc040000000-0xffffffc080000000           1G     RW NX SHD
> AF        BLK UXN MEM/NORMAL
>
> are there other parts of the map you're seeing that aren't on my system?


Thats my mistake, I didn't remember seeing the NX set for the block 
mappings with the RO case, the machine I just checked looks good too. 
So, I you can ignore that little rant.
