From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Thu, 1 Feb 2018 10:17:26 +0100
Subject: Patch submission process about at91 DTS
In-Reply-To: <1337f0d7-c112-e9db-6677-cbd2c58b1b06@gmail.com>
References: <20180131170453.GA16869@tp.shaiton.org>
 <1337f0d7-c112-e9db-6677-cbd2c58b1b06@gmail.com>
Message-ID: <54728290-3f8c-1cd3-1f03-aeaa545bdcdc@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2018 at 10:03, Florian Vaussard wrote:
> Hi K?vin,

Thanks to you Florian and Alexander for having answered to K?vin!

> Le 31. 01. 18 ? 18:04, K?vin Raymond a ?crit?:
>> Hi there,
>>
>> We have several at91-kizbox* DTSs and I have few patches to suggest.
>> The idea is to split one dts over dtsi + several dts.

When you talk about "several"... what is the rough amount?

We are using this arrangement on our own "vendor tree" branches and
tried to not send too much .dts variants to Mainline... We now plan to
move to something more maintainable and elegant like the DT overlays.
They will be loaded by the bootloader and certainly stored in our own
overlays git repository.

What about just having a superset in Mainline and providing variants on
your own repository? Beware of thinking about maintenance while sending
a big amount of .dts variants to Mainline...

>> My current patches are based an tested over the linux repo[0] against the
>> master branch (4e19652 Update the RISC-V MAINTAINERS file).
>>
>> Should I rebase them against the linux-at91[1] repository? Which branch,
>> at91-next? I would love them to reach the 4.14 branch but am not sure of
>> the right path to submit those changes.
>>
> 
> Linux 4.14 is already out, so only patches for a stable release can be
> backported. See in Documentation/process/stable-kernel-rules.rst for the
> rules. I guess that your patches do not apply for stable. So your patches
> will be applied to a latter release (4.16 if you are lucky as the merge window
> is now opened but most probably 4.17+).
> 
> For the submission process itself, please read Documentation/process/* and
> especially "5.Posting.rst" and "submitting-patches.rst". There is also a
> documentation specific to DT patches in Documentation/devicetree/bindings/
> submitting-patches.txt.
> 
> TL;DR look into the MAINTAINERS file or use ./scripts/get_maintainer.pl.
> For your AT91 patches, you should CC the maintainers:
> 
> - Nicolas Ferre <nicolas.ferre@microchip.com>
> - Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> You should also CC the DT mainling list.
> 
> Finally the AT91 Git tree is here [1]. Use that unless told differently by the
> maintainers.
> 
> Best,
> Florian
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git

Yes, this tree is mostly useful for its up-to-date at91-next branch.

Alexandre's git tree is here:
https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/
And it's usually where Alexandre build the topic branches that will be
sent to upstream (arm-soc actually).

So, both at91-next branch on my tree or at91-dt on Alexandre's one
usually do the trick.

Anyway, we'll communicate with you if anything needs to be enhanced on
your patches.

Best regards,
-- 
Nicolas Ferre
