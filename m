From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 22:04:07 +0100
Subject: [PATCH] ARM: support XZ compressed kernels
In-Reply-To: <op.vybi03ze2s3iss@ecaz>
References: <1310033999-25617-1-git-send-email-kaloz@openwrt.org>
	<20110708203832.GV4812@n2100.arm.linux.org.uk>
	<op.vybi03ze2s3iss@ecaz>
Message-ID: <20110708210407.GY4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 10:54:29PM +0200, Imre Kaloz wrote:
> On Fri, 08 Jul 2011 22:38:32 +0200, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>
>> On Thu, Jul 07, 2011 at 12:19:59PM +0200, Imre Kaloz wrote:
>>>  # Make sure files are removed during clean
>>> -extra-y       += piggy.gzip piggy.lzo piggy.lzma lib1funcs.S
>>> +extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern lib1funcs.S ashldi3.S
>>
>> Is there a reason the suffix is xzkern rather than just xz ?
>
> We do "$(call if_changed,$(suffix_y))" and scripts/Makefile.lib
> uses cmd_xzkern. I think keeping the changes minimal worth more
> then having the proper suffix for a temporary file.

Hmm, that's unfortunate.  It seems that it may be a non-standard format
so I guess that's reasonable.  No further comments then.
