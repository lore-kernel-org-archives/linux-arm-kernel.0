From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Mon, 6 May 2013 20:23:13 -0400
Subject: [RESEND][PATCH 1/3] arm: dts: introduce config HAS_BANDGAP
In-Reply-To: <20130506223653.GA12089@obsidianresearch.com>
References: <1367874058-2378-1-git-send-email-eduardo.valentin@ti.com>
 <1367874058-2378-2-git-send-email-eduardo.valentin@ti.com>
 <20130506213413.GH5634@blackmetal.musicnaut.iki.fi>
 <20130506223653.GA12089@obsidianresearch.com>
Message-ID: <51884971.9050508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06-05-2013 18:36, Jason Gunthorpe wrote:
> On Tue, May 07, 2013 at 12:34:13AM +0300, Aaro Koskinen wrote:
>> On Mon, May 06, 2013 at 05:00:56PM -0400, Eduardo Valentin wrote:
>>> Introduce HAS_BANDGAP config entry. This config is a
>>> boolean value so that arch code can flag is they
>>> feature a bandgap device.
>>
>> Maybe it could be mentioned that omap-thermal already depend on this?
>> At least for a random reviewer it was not immediately clear why this is
>> added, especially since there were no users for it in subsequent patches.
> 
> I looked (very briefly), and it seemed like omap-thermal is self
> contained and doesn't need arch support?
> 

It is. At least I tried to make it, at least to the extenstion I could get.

> I get the impression it is desired to minimize driver kconfig
> dependencies to the minimum required to compile to increase build
> testing coverage, so maybe it would be appropriate to drop this
> entirely?
> 

Well, it is also desired to compile things to the correct target right?
Thats the idea behind this config option. It follows the same design as
CONFIG_ARCH_HAS_CPUFREQ, for instance.

> Jason
> 
> 


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130506/3a925826/attachment-0001.sig>
