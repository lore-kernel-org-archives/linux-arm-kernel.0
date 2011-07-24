From: sboyd@codeaurora.org (Stephen Boyd)
Date: Sun, 24 Jul 2011 15:40:46 -0700
Subject: [PATCH] ARM: Set proper TEXT_OFFSET for newer MSMs
In-Reply-To: <alpine.LFD.2.00.1107241548170.1762@xanadu.home>
References: <1311529149-20213-1-git-send-email-sboyd@codeaurora.org>
	<alpine.LFD.2.00.1107241548170.1762@xanadu.home>
Message-ID: <4E2C9F6E.9070207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2011 12:56 PM, Nicolas Pitre wrote:
> On Sun, 24 Jul 2011, Stephen Boyd wrote:
>> +static void __init msm7x30_fixup(struct machine_desc *desc, struct tag *tag,
>> +			 char **cmdline, struct meminfo *mi)
>> +{
>> +	for (; tag->hdr.size; tag = tag_next(tag))
>> +		if (tag->hdr.tag == ATAG_MEM && tag->u.mem.start == 0x200000)
>> +			tag->u.mem.start = 0;
>> +}
> Don't you need to also increase tag->u.mem.size  by 2MB ?

Thanks. I was fixated on the start address.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
