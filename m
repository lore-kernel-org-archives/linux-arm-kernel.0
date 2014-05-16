From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 16 May 2014 11:42:18 +0300
Subject: [PATCH 00/11] ARM: OMAP: OMAP5 & AM43x DSS
In-Reply-To: <20140512143604.GB31772@atomide.com>
References: <1399636579-8062-1-git-send-email-tomi.valkeinen@ti.com>
 <5370CBD5.3060107@ti.com> <20140512143604.GB31772@atomide.com>
Message-ID: <5375CF6A.7030602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/14 17:36, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 06:26]:
>> Hi Tony,
>>
>> On 09/05/14 14:56, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> Here are arch/arm/ patches to add display support for OMAP5 and AM43x.
>>>
>>> I have these in my tree, in a branch I will send to Tony for merging. Most of
>>> these patches have already been around the lists, but I wanted to send them one
>>> more time to verify that all looks right and everybody is fine with them.
>>
>> I have pushed these to:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git 3.16/omap
>>
>> If you're fine with these, I think we can consider that branch stable.
>> There are probably still a few display related .dts changed for the
>> board coming up, but I'll add those on top of the current commits.
> 
> Please coordinate things with Paul and Tero so you at least have proper
> acks for the hwmod and and clock patches. In general we really want to
> queue hwmod and clock changes separately as those can easily mess up things
> in a bad way like we've already seen with overlapping hwmod entries in
> the .dts files.

I don't think the clock dts changes can be separated from the other dts
changes, as the new 'dss_l3_iclk' clock node is required by the
omap5.dtsi when adding the DSS support.

The HWMOD patches can go separately.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140516/6e0779cc/attachment.sig>
