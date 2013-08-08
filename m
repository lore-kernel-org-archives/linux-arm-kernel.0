From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 8 Aug 2013 23:02:50 +0530
Subject: [PATCH 1/2] include: dt-binding: input: create a DT header
 defining key codes.
In-Reply-To: <20130808171331.GA6960@core.coreip.homeip.net>
References: <1375798370-2231-1-git-send-email-ldewangan@nvidia.com>
 <52014E50.6030508@wwwdotorg.org> <5203D138.4030107@nvidia.com>
 <20130808171331.GA6960@core.coreip.homeip.net>
Message-ID: <5203D642.60405@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 August 2013 10:43 PM, Dmitry Torokhov wrote:
> On Thu, Aug 08, 2013 at 10:41:20PM +0530, Laxman Dewangan wrote:
>> On Wednesday 07 August 2013 12:58 AM, Stephen Warren wrote:
>>> (CC'ing DT bindings maintainers too, hence quoting a bit of the patch)
>>>
>>> On 08/06/2013 08:12 AM, Laxman Dewangan wrote:
>>>> Many of Key device tree bindings uses the constant number as key code
>>>> which matches with kernel header key code and then comment as follows
>>>> for reference/better readability:
>>>> 	linux,code = <102>; /* KEY_HOME */
>>>>
>>>> Create a DT header which defines all the key code so that DT key bindings
>>>> can use it as follows:
>>>> 	linux,code = <KEY_HOME>;
>>> This looks fine to me.
>>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>>>
>>> A comment in support of the patch: This is adding OS-specific content to
>>> the DT. However, the bindings this header file supports are already
>>> written that way. There's not really any alternative here, since some
>>> numbering scheme had to be chosen for keycodes, and it may as well be
>>> the same set as the first/primary OS that'll use the binding.
>>>
>>> As far as merging it, this patch should probably go through the core DT
>>> tree, perhaps in a topic branch so that e.g. Tegra an MVEBU can merge it
>>> in to apply your subsequent patches (or we can just wait until the next
>>> kernel release to merge them in).
>> Do I need to include anyone for this patch to be applied or can go
>> through Dmitry's input git branch?
> I am uncomfortable that we are duplicating the whole list of keycodes
> here. Do you think we could split keycodes and other event codes from
> include/uapi/linux/input.h into include/uapi/linux/input-events.h and
> unclude it directly into DTS?

Yes, it will be very much possible to split this but I am not sure it is 
allowed to include the header in DTS file which is not inside 
include/dt-bindings.
If there is no limitation/restriction then we can split this adn amke 
single header for key code which will be used by code and dts.
