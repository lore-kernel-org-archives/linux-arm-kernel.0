From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 8 May 2012 15:57:59 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <4FA93391.8040905@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
 <4FA90BE1.3050304@linaro.org>
 <20120508121940.GL15893@opensource.wolfsonmicro.com>
 <4FA913BA.30908@linaro.org>
 <20120508133411.GP15893@opensource.wolfsonmicro.com>
 <4FA93391.8040905@linaro.org>
Message-ID: <20120508145758.GV15893@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 03:54:09PM +0100, Lee Jones wrote:
> On 08/05/12 14:34, Mark Brown wrote:

> >Looking at the usage here it looks like most of this stuff shouldn't be
> >there even with non-DT stuff, we probably don't want to add DT bindings
> >for those bits.All the voltage setting is not at all device specific
> >and can be done using the generic regulator bindings, the forcing on or
> >off is similarly generic.

> All the generic properties _are_ set using the generic bindings. The
> only vendor specific values are the initialisation register values
> referenced above. I'll see what happens when I remove those from DT.
> I have a feeling that the regulators will just fail though.

The comments in the arch/arm file indicate otherwise - they were talking
about enabling and disabling regulators, and about setting voltages.  It
may be that the comments in the arch/arm code are inaccurate but with it
being magic numbers you'd really hope they're accurate...

> >While looking for the original patch I also noticed that you're not CCing
> >the mailing list either...  please always CC the subsystem mailing list
> >on patches.

> You don't appear to have one. I ran get_maintainer.pl on the patch
> and the only ML it came up with was LKML. If you do have one, you
> may need to update the MAINTAINERS file.

LKML is the relevant list here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120508/0d149ee3/attachment.sig>
