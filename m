From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 6 Sep 2016 14:23:16 +0100
Subject: [PATCH v2 7/7] ARM: KVM: Unlock vgic-v3 support
In-Reply-To: <20160905112927.GL26366@cbox>
References: <1471344418-19568-1-git-send-email-vladimir.murzin@arm.com>
 <1471344418-19568-8-git-send-email-vladimir.murzin@arm.com>
 <20160905112927.GL26366@cbox>
Message-ID: <57CEC344.7030706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Sorry, missed this one

On 05/09/16 12:29, Christoffer Dall wrote:
>>  
>> > +static bool __hyp_text __has_useable_gicv3_cpuif(void)
>> > +{
>> > +	if (IS_ENABLED(CONFIG_ARM_GIC_V3) && (read_sysreg(ID_PFR1) >> 28))
> Do we have a define for bit 28 we could use?

I'll check it.

> 
> Does this actually work on all v7 boards?  The v7 ARM ARM seems to state
> that this bitfield is Reserved, UNK.  Does that somehow mean 'is going
> to be zero'?

It is how v7ARM ARM I have defines UNK

An abbreviation indicating that software must treat a field as
containing an UNKNOWN value. Hardware must implement the bit as read as
0, or all 0s for a bit field. Software must not rely on the field
reading as zero.

It seems goes under 'is going to be zero' case, no?

Cheers
Vladimir
