From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 1 Mar 2016 23:46:59 +0100
Subject: [PATCH 7/8] ARM64: dts: amlogic: Extend GXBaby GIC node
In-Reply-To: <56D58E88.2080700@arm.com>
References: <1456789465-2962-1-git-send-email-afaerber@suse.de>
 <1456789465-2962-8-git-send-email-afaerber@suse.de>
 <56D57673.8030702@arm.com> <56D57A7F.5020806@suse.de>
 <56D58E88.2080700@arm.com>
Message-ID: <56D61BE3.90505@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.03.2016 um 13:43 schrieb Andre Przywara:
> On 01/03/16 11:18, Andreas F?rber wrote:
>> Am 01.03.2016 um 12:01 schrieb Andre Przywara:
>>> On 29/02/16 23:44, Andreas F?rber wrote:
>>>>  			reg = <0x0 0xc4301000 0 0x1000>,
>>>> -			      <0x0 0xc4302000 0 0x0100>;
>>>> +			      <0x0 0xc4302000 0 0x0100>,
>>>
>>> Please use 0x2000 for the size here. I guess this is really the GIC-400
>>> from ARM, and in this case this is the right size, [1] is the reference
>>> here. This will enable EOI mode 1 for KVM.
>>
>> Will test later.
>>
>> Is there any easy way to find out whether or not this is that GIC-400?
> 
> If you can read registers: GICD_IIDR and PIDRx have some info:
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0471b/CHDIFAEE.html
> So if your U-Boot for instance supports md, a dump of:
> md.l c4301008 1
> md.l c4301fd0 30
> 
> would help to identify the GIC.

gxb_p200_v1#md.l c4301008 1
c4301008: 0200143b                               ;...
gxb_p200_v1#md.l c4301fd0 30
c4301fd0: 00000004 00000000 00000000 00000000    ................
c4301fe0: 00000090 000000b4 0000002b 00000000    ........+.......
c4301ff0: 0000000d 000000f0 00000005 000000b1    ................
c4302000: 00000060 000000f0 00000003 000003ff    `...............
c4302010: 00000000 000000ff 000003ff 00000000    ................
c4302020: 00000000 00000000 00000000 00000000    ................
c4302030: 00000000 00000000 00000000 00000000    ................
c4302040: 00000000 00000000 00000000 00000000    ................
c4302050: 00000000 00000000 00000000 00000000    ................
c4302060: 00000000 00000000 00000000 00000000    ................
c4302070: 00000000 00000000 00000000 00000000    ................
c4302080: 00000000 00000000 00000000 00000000    ................

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
