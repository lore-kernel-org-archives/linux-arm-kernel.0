From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 08 May 2012 18:00:20 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <20120508145758.GV15893@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
 <4FA90BE1.3050304@linaro.org>
 <20120508121940.GL15893@opensource.wolfsonmicro.com>
 <4FA913BA.30908@linaro.org>
 <20120508133411.GP15893@opensource.wolfsonmicro.com>
 <4FA93391.8040905@linaro.org>
 <20120508145758.GV15893@opensource.wolfsonmicro.com>
Message-ID: <4FA95124.5010309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/12 15:57, Mark Brown wrote:
> On Tue, May 08, 2012 at 03:54:09PM +0100, Lee Jones wrote:
>> On 08/05/12 14:34, Mark Brown wrote:
>
>>> Looking at the usage here it looks like most of this stuff shouldn't be
>>> there even with non-DT stuff, we probably don't want to add DT bindings
>>> for those bits.All the voltage setting is not at all device specific
>>> and can be done using the generic regulator bindings, the forcing on or
>>> off is similarly generic.
>
>> All the generic properties _are_ set using the generic bindings. The
>> only vendor specific values are the initialisation register values
>> referenced above. I'll see what happens when I remove those from DT.
>> I have a feeling that the regulators will just fail though.
>
> The comments in the arch/arm file indicate otherwise - they were talking
> about enabling and disabling regulators, and about setting voltages.  It
> may be that the comments in the arch/arm code are inaccurate but with it
> being magic numbers you'd really hope they're accurate...

Fingers crossed. I'll let you know how I get on.

>>> While looking for the original patch I also noticed that you're not CCing
>>> the mailing list either...  please always CC the subsystem mailing list
>>> on patches.
>
>> You don't appear to have one. I ran get_maintainer.pl on the patch
>> and the only ML it came up with was LKML. If you do have one, you
>> may need to update the MAINTAINERS file.
>
> LKML is the relevant list here.

Ah, okay. In retrospect I don't know why I didn't add it to be honest. 
I'll endeavor to do so next time.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
