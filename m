From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 Aug 2017 11:20:42 +0100
Subject: [PATCH] arm64: dts: marvell: add Device Tree files for Armada-8KP
In-Reply-To: <022fd386-a9a9-6f9d-27a9-3a63b5a81bbf@marvell.com> (Hanna Hawa's
 message of "Wed, 9 Aug 2017 09:29:25 +0300")
References: <1502195474-9585-1-git-send-email-hannah@marvell.com>
 <6017865e-e0a4-a316-45da-924af7126f91@arm.com>
 <022fd386-a9a9-6f9d-27a9-3a63b5a81bbf@marvell.com>
Message-ID: <86inhxxcsl.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09 2017 at  9:29:25 am BST, Hanna Hawa <hannah@marvell.com> wrote:
> On 08/08/2017 04:06 PM, Marc Zyngier wrote:
>> On 08/08/17 13:31, hannah at marvell.com wrote:

[...]

>>> +				ranges;
>>> +
>>> +				reg = <0x3000000 0x10000>,     /* GICD */
>>> +				      <0x3060000 0x100000>;    /* GICR */
>>
>> Where is the GICv2 compatibility region (GICV)that is provided by each
>> A72 cores? It should be at PERIPHBASE+0x20000 (see
>> http://infocenter.arm.com/help/topic/com.arm.doc.100095_0003_06_en/way1382452674438.html).
> Currently virtualization out of our focus, I add GICV region & it not
> tested.

To be completely blunt, this is a bit out of your hands. The HW exists
(it is part of the Cortex-A72 core), and it should be described. If it
doesn't work for one reason or another, then this is a defect and we
should treat it as such.

Also, you do describe the maintenance interrupt, whose sole purpose is
to support virtualization.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
