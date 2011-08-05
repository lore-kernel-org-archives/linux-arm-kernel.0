From: scottwood@freescale.com (Scott Wood)
Date: Fri, 5 Aug 2011 15:26:29 -0500
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <CAKGA1bkM6X533w20hDV7GCPwzzj2nrjGdN6zkXsS+hCvUD_s2A@mail.gmail.com>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>	<20110725204630.GD26735@ponder.secretlab.ca>	<CAKGA1bmbWUeyhUtDwHZjB8V4e2wJ0NHX2qWhqaqx6HoBm7uMnQ@mail.gmail.com>	<20110805070729
Message-ID: <4E3C51F5.50707@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2011 01:36 PM, Matt Sealey wrote:
> On Fri, Aug 5, 2011 at 2:07 AM, David Brown <davidb@codeaurora.org> wrote:
>> On Thu, Aug 04, 2011 at 06:07:15PM -0500, Matt Sealey wrote:
>>> Hi Grant, Shawn,
>>>
>>> On Mon, Jul 25, 2011 at 3:46 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>>> This could get really verbose in a really big hurry.  Fortunately the
>>>> dtb format is sophisticated enough to only store each unique property
>>>> name once, so the data shouldn't be huge, but it is still going to
>>>> make for huge source files.  Can you think of a more concise
>>>> representation?
>>>
>>> Yes: no representation at all. The correct place for IOMUX setup being
>>> done is *inside the boot firmware as soon as physically possible* and
>>> not seconds into boot after U-Boot has made a console, done a boot
>>> timeout, loaded scripts, kernels and ramdisks from media and then
>>> uncompressed and entered a Linux kernel.
>>
>> This is true in situations where we have control over the bootloader,
>> but that isn't always the case.
> 
> Indeed it is not, but then it is "their" fault the board won't boot
> Linux, and not yours, right? :)
> 
> I think it is a given that when designing hardware (and we do that)
> and proprietary firmware that the Linux kernel guys can't "control",
> you have to keep up with the changes when reasonable. While sometimes
> that is very difficult, this is not one of those "sometimes" -
> providing a setup that can boot Linux implies that you configured the
> chip correctly such that Linux is supplementing that configuration,
> not reimplementing it from scratch.

In the absence of a time machine, situations where one might not want to
upgrade firmware are not limited to proprietary firmware.  The means to
recover from a bricked board are not always available and convenient.

This is why we did pin setup in Linux for 8xx/82xx, and why we did cuImage.

If you haven't yet shipped the boards with bad firmware to an extent
that requires compatibility, that's a different situation of course.

> Yes, it puts the onus of the work on the firmware guys, but they're
> the ones writing the device trees for their hardware anyway.

Sometimes.

-Scott
