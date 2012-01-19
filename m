From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 19 Jan 2012 17:00:56 +0000
Subject: [PATCH v6 9/9] ARM: vexpress: Add Device Tree for V2P-CA15 core
 tile (TC1 variant)
In-Reply-To: <1326984672.32197.68.camel@hornet.cambridge.arm.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>	
 <1323957761-13553-10-git-send-email-pawel.moll@arm.com>	
 <4F0C495C.4000103@citrix.com>	
 <1326979652.32197.66.camel@hornet.cambridge.arm.com>	
 <4F181BD9.20401@gmail.com>	
 <1326980594.32197.67.camel@hornet.cambridge.arm.com>	
 <4F182248.7070209@gmail.com>
 <1326984672.32197.68.camel@hornet.cambridge.arm.com>
Message-ID: <4F184C48.2050505@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/12 14:51, Pawel Moll wrote:
> On Thu, 2012-01-19 at 14:01 +0000, Rob Herring wrote:
>> On 01/19/2012 07:43 AM, Pawel Moll wrote:
>>> On Thu, 2012-01-19 at 13:34 +0000, Rob Herring wrote:
>>>>> You're right - the skeleton.dtsi contains "memory" mode... Funnily
>>>>> enough originally I was using that name, but then Rob Herring suggested
>>>>> changing it to @80000000, which seemed reasonable.
>>>>>
>>>>> Now I wonder - is the "memory" node special and should not contain
>>>>> "@address", or the skelton shouldn't contain the empty "memory" node...
>>>>>
>>>>
>>>> Hummm... I guess you should just use "memory" if you are using
>>>> skeleton.dtsi.
>>>
>>> Well, I don't mind _not_ using skeleton, but I had an impression the
>>> general policy was to use it?
>>
>> Either way is fine. I don't really think it buys you much.
> 
> Ok, /include/ "skeleton.dtsi" is gone then :-)

The problem wasn't with including skeleton.dtsi.  With
CONFIG_ARM_ATAG_DTB_COMPAT the zImage decompressor modifies the appended
DTB using information from the ATAGs (see atags_to_fdt()).

If there's an ATAG giving the amount of RAM the DTB's "memory" node is
replaced with a new one.  Since the vexpress DTBs don't have a "memory"
node it's added and the DTB ends up with two nodes describing memory.

I don't expect any real production vexpress system to use this config
options -- we're using it now when running as a guest under Xen because
Xen doesn't (yet) support device tree and we're using ATAGs to tell the
guest how much RAM it's been allocated.

David
