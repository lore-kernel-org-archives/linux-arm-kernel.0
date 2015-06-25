From: achandran@mvista.com (Arun Chandran)
Date: Thu, 25 Jun 2015 17:50:36 +0530
Subject: BUG: Bad page state in process swapper pfn:XXXXX
In-Reply-To: <558BDF49.7020908@arm.com>
References: <CAFdej03jedihbdNCb8e+at3M3ikKxn+s6eAvBvfGPdtsHShQdQ@mail.gmail.com>
 <CAFdej029n2DHQRZmFp78hNUgA=rWGYK0fXG1+AxQEZrUGf3WdA@mail.gmail.com>
 <558BDF49.7020908@arm.com>
Message-ID: <CAFdej01D6T7r3fhLXGSOj0BFO=TPJmc0oKAt0RLhWWQjyT_Wkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 25, 2015 at 4:30 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Arun,
>
> On 25/06/15 11:08, Arun Chandran wrote:
> [...]
>
>> A u-boot memtest for those areas resulted in errors[1 in 5 boots]
>>
>> SOCFPGA_ARRIA5 #  mtest 0x1ff3a000 0x1ff4ffff
>> Pattern 00000002  Writing...  Reading...
>> Mem error @ 0x1FF4A714: found FFFFFFFF, expected 000041C7
>>
>> Mem error @ 0x1FF4A718: found 1C00FFFF, expected 000041C8
>>
>> Mem error @ 0x1FF4A71C: found 143DCB25, expected 000041C9
>>
>> Mem error @ 0x1FF4A720: found 01000608, expected 000041CA
>>
>> Mem error @ 0x1FF4A724: found 04060008, expected 000041CB
>>
>> Mem error @ 0x1FF4A728: found 1C000100, expected 000041CC
>>
>> Mem error @ 0x1FF4A72C: found 143DCB25, expected 000041CD
>>
>> Mem error @ 0x1FF4A730: found 1967A20A, expected 000041CE
>>
>> Mem error @ 0x1FF4A734: found 00000000, expected 000041CF
>>
>> Mem error @ 0x1FF4A738: found A20A0000, expected 000041D0
>>
>> Mem error @ 0x1FF4A73C: found 00001667, expected 000041D1
>>
>> Mem error @ 0x1FF4A740: found 00000000, expected 000041D2
>>
>> Mem error @ 0x1FF4A744: found 00000000, expected 000041D3
>>
>> Mem error @ 0x1FF4A748: found 00000000, expected 000041D4
>>
>> Mem error @ 0x1FF4A74C: found 00000000, expected 000041D5
>>
>> Mem error @ 0x1FF4A750: found E3D2A784, expected 000041D6
>> Pattern 0000000A  Writing...  Reading...
>> Mem error @ 0x1FF3AE14: found 005A0320, expected 0000038F
>> Pattern FFFFFFF4  Writing...  Reading...
>> Mem error @ 0x1FF3AE14: found 00400320, expected FFFFFC6F
>> Pattern FFFFFFEF  Writing...  Reading...
>>
>>
>> That means there is problem with my RAM [or board reset].
>
>
> Or that your bootloader is leaving the network controller DMA'ing over
> kernel memory. That 'corruption' has a suspiciously familiar shape to it,
> and sure enough, turns out to be a valid ethernet packet - Wireshark had
> this to say about it:
>
> 1       0.000000000     HonHaiPr_cb:3d:14       Broadcast       ARP     64
> Who has 10.162.103.22?  Tell 10.162.103.25
>
> Robin.


Hi Robin,

Nice catch. Thanks for pointing that out.

--Arun
