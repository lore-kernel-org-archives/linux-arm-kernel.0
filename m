From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 26 Nov 2009 20:03:26 +0100
Subject: IXP425: help on HSS channelized service
In-Reply-To: <20091126144956.GA7150@n2100.arm.linux.org.uk> (Russell King's
	message of "Thu, 26 Nov 2009 14:49:56 +0000")
References: <4B0BDFC1.7010506@kaskonetworks.it>
	<m3d437bi7i.fsf@intrepid.localdomain>
	<200911261543.08448.schindele@nentec.de>
	<20091126144956.GA7150@n2100.arm.linux.org.uk>
Message-ID: <m33a41un0h.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> struct desc {
>>         u32 next;               /* pointer to next buffer, unused */
>> 
>> #ifdef __ARMEB__
>>         u16 buf_len;            /* buffer length */
>>         u16 pkt_len;            /* packet length */
>>         u32 data;               /* pointer to data buffer in RAM */
>>         u8 status;
>>         u8 error_count;
>>         u16 __reserved;
>> #else
>>         u16 pkt_len;            /* packet length */
>>         u16 buf_len;            /* buffer length */
>>         u32 data;               /* pointer to data buffer in RAM */
>>         u16 __reserved;
>>         u8 error_count;
>>         u8 status;
>> #endif
>>         u32 __reserved1[4];
>
> If these structures are sensitive to the byte-endian, they should be
> defined using [bl]e(32|16|8) so that sparse can check that you're
> using appropriate cpu_to_xxx() and xxx_to_cpu() endian conversions on
> them.

The values are in CPU order. I'll run sparse on this stuff, haven't done
that in a (too) long time.

It used to work in both LE and BE modes, though.
-- 
Krzysztof Halasa
