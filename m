From: architt@codeaurora.org (Archit Taneja)
Date: Mon, 26 Sep 2016 15:58:04 +0530
Subject: [PATCH V5 3/4] drm/bridge: Add driver for GE B850v3 LVDS/DP++
 Bridge
In-Reply-To: <3a56-57e8e300-3-10c8a340@87357206>
References: <3a56-57e8e300-3-10c8a340@87357206>
Message-ID: <8a7a0b02-5b9f-4266-75a2-42f26fcbc352@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/26/2016 02:28 PM, Peter Senna Tschudin wrote:
>  Hi Archit,
>
> On Monday, September 26, 2016 10:31 CEST, Archit Taneja <architt@codeaurora.org> wrote:
>
>> Hi Peter,
>>
>> On 09/26/2016 01:57 PM, Peter Senna Tschudin wrote:
>>> Patch 1/4 is already on linux-next, but what about this one? Ping?
>
>>
>> I'd posted some queries a couple of times which you didn't answer to.
>> Could you please respond to them before we try to get this merged?
>
> Your queries were already answered by similar questions. The commit messages and cover letter also addresses the design decisions of the code. But basically the driver usefulness to other scenarios is severely limited by the firmware used by both chips. And when using the firmware that goes with this specific hardware, then yes, the two chips are always expected to work together. But the main point is that with the custom firmware each chip do not behave as independent bridges anymore.

Thanks for the reply.

It wasn't entirely clear from the commit message that a custom firmware
was exclusively used on this board to program these chips in order to
get these 2 working together.

I browsed the earlier versions of the patch and saw you explained
the same thing to someone else. Sorry about that, I missed reading
that before.

Could you please specify this explicitly in the commit message? Perhaps,
also mention that there is an external microcontroller with a custom
firmware that manages most of the video operations. For the sake of
completeness, could you also mention the part name of the controller
that's running this firmware?

Also, in the comments in the beginning of the driver:

"However the physical bridges are automatically configured by the input 
video signal, and the driver has no access to the video processing 
pipeline."

Is the automatic configuration done by the firmware, or is it a
feature of the chips itself?

>
> On the other side, I was careful to use meaningful names for the registers, so a future implementation based on same chips can take the basics from this work, at least as a starting point.

Thanks, that would be handy for later.

I had some comments on the code. I'll share those in another reply.

Archit

>
> Thanks,
>
> Peter
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
