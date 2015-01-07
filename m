From: jcm@redhat.com (Jon Masters)
Date: Wed, 07 Jan 2015 15:14:50 -0500
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20150107200530.GK2634@sirena.org.uk>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <20150107172741.GY2634@sirena.org.uk> <54AD7098.5010700@redhat.com>
 <1610983.9vqJdsL27R@wuerfel> <20150107200530.GK2634@sirena.org.uk>
Message-ID: <54AD93BA.3020904@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2015 03:05 PM, Mark Brown wrote:
> On Wed, Jan 07, 2015 at 08:48:48PM +0100, Arnd Bergmann wrote:
>> On Wednesday 07 January 2015 12:44:56 Jon Masters wrote:
>>> On 01/07/2015 12:27 PM, Mark Brown wrote:
> 
>>>> That level of hardware compatibility does partly come from the need to
>>>> run existing software.  I'd expect that similar effects will start to
>>>> come into play with ARMv8 ACPI systems if they become successful; people
>>>> will do things like ensure compatibility with common IPs that have
>>>> existing Linux drivers that distros tend to include as standard.
> 
>>> Agreed.
> 
>> There are two problems I see in trying to do the same thing on ARM:
> 
>> * we don't have a single vendor that makes de-facto standards that
>>   everyone else has to copy in the way that the few remaining x86
>>   vendors copy everything that Intel does. In fact, we prefer to
>>   have a large number of independent vendors.
> 
> Right, I'd guess that (modulo any standards being defined and becoming
> successful) it'll more be a case of vendors keeping compatibility with
> their own stuff.  We *are* seeing greater reliance on off the shelf IPs
> for more boring things like DMA and basic bus controllers but there's
> plenty of other areas that still affect servers.

I expect to see a greater level of standardization. SBBR is the
beginning, but it is far from the end. There will be a lot more as the
vendors come together and agree on common platform components. I've
spent a lot of time over the past few years with a large number of
vendors going over lots of these issues in lieu of more of a Windows
Hardware Qualification style guide. I intend to have one this year that
captures what Red Hat think an ARM server looks like, and to circulate
that among the broader ecosystem of vendors to feed into SBBR++.

>> * There is a general mindset about deprecating unwanted features
>>   early. ARMv8 aarch32 bit mode removes support for older instructions
>>   or makes them optional. Even the virtualization mode doesn't allow
>>   to trap on architecture version specific differences, so you can't
>>   completely emulate an older architecture level.
>>   This is nice for implementers but not so much for users that rely
>>   on old (mis-)features. It's also not just the CPU core, other
>>   components also get easily replaced, like a GICv3 that is not
>>   a strict superset of GICv2.
> 
> This is indeed worrying, though hopefully the fact that we're already
> seeing negative impacts in the app ecosystem for Android will have
> focused some minds - once you're talking about full system images it
> gets even more fun.

GICv2/3 was something a bunch of us discussed years ago. At the time we
debated whether there was a need to compel the superset option. It was
deemed early enough not to be a critical issue. But there have already
been other cases where we've pushed to ensure backward compatibility for
all time. And there will be more of those as the ecosystem develops out
into a world of existing Operating System images and apps that need to
run on these emerging platforms. Deprecating instructions and
formalizing other behaviors is an area where it's ephemeral - what made
sense in the past might not make sense in the future, and ARM know that.
Their architecture team features some of the smartest minds.

(on architecture revisions, Red Hat has stated in the past that we only
care about AArch64, not even running 32-bit code on 64-bit processors,
which is one reason I have pushed for some silicon designs not to
implement the 32-bit compatibility when it comes to servers)

Jon.
