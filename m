From: wmb@firmworks.com (Mitch Bradley)
Date: Fri, 05 Aug 2011 13:31:10 -1000
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <20110805225845.GC6404@ponder.secretlab.ca>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
	<CAKGA1bmbWUeyhUtDwHZjB8V4e2wJ0NHX2qWhqaqx6HoBm7uMnQ@mail.gmail.com>
	<20110805225845.GC6404@ponder.secretlab.ca>
Message-ID: <4E3C7D3E.7040502@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/5/2011 12:58 PM, Grant Likely wrote:
> On Thu, Aug 04, 2011 at 06:07:15PM -0500, Matt Sealey wrote:
>> Hi Grant, Shawn,
>>
>>
>>
>> On Mon, Jul 25, 2011 at 3:46 PM, Grant Likely<grant.likely@secretlab.ca>  wrote:
>>> This could get really verbose in a really big hurry.  Fortunately the
>>> dtb format is sophisticated enough to only store each unique property
>>> name once, so the data shouldn't be huge, but it is still going to
>>> make for huge source files.  Can you think of a more concise
>>> representation?
>>
>> Yes: no representation at all. The correct place for IOMUX setup being
>> done is *inside the boot firmware as soon as physically possible* and
>> not seconds into boot after U-Boot has made a console, done a boot
>> timeout, loaded scripts, kernels and ramdisks from media and then
>> uncompressed and entered a Linux kernel.
>
> We've had this argument before.  There are many use cases where the
> firmware simply cannot be relied upon to do the right thing.

I am a firmware engineer who tries very hard to deliver quality firmware 
that does the right thing.  It often seems to me that the Linux kernel 
community's general distrust of firmware is a self-fulfilling prophecy. 
  People often "live down to expectations"; if Linux expects the 
firmware to be worthless, worthless is often what you get.

In the PC BIOS world, the quality of BIOSes went up dramatically when 
Microsoft began insisting that the BIOS must meet stringent standards, 
enforced via an exhaustive suite of compatibility tests.

>
> g.
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
>
