From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 30 Nov 2017 23:06:33 +0100
Subject: [PATCH v3 4/4] DTS: Pandora: fix panel compatibility string
In-Reply-To: <20171130152430.GM28152@atomide.com>
References: <cover.1511884135.git.hns@goldelico.com>
 <b6001c7b7fb98e7a3ad4c712084fea9dae9e6b27.1511884135.git.hns@goldelico.com>
 <20171128160437.GD28152@atomide.com>
 <ADAFBBA4-6AC4-4EC4-AB0E-98B59718E12E@goldelico.com>
 <20171128161834.GE28152@atomide.com>
 <4EE1E298-6461-48FF-977C-958DD16AD83A@goldelico.com>
 <20171130152430.GM28152@atomide.com>
Message-ID: <20171130220633.imkfyeiqtftnw4j4@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 30, 2017 at 07:24:30AM -0800, Tony Lindgren wrote:
> * H. Nikolaus Schaller <hns@goldelico.com> [171128 18:35]:
> > Hi,
> > 
> > > Am 28.11.2017 um 17:18 schrieb Tony Lindgren <tony@atomide.com>:
> > > 
> > > * H. Nikolaus Schaller <hns@goldelico.com> [171128 16:17]:
> > >> Hi Tony,
> > >> 
> > >>> Am 28.11.2017 um 17:04 schrieb Tony Lindgren <tony@atomide.com>:
> > >>> 
> > >>> * H. Nikolaus Schaller <hns@goldelico.com> [171128 15:52]:
> > >>>> We can remove the unnecessary "omapdss," prefix because
> > >>>> the omapdrm driver takes care of it when matching with
> > >>>> the driver table.
> > >>> 
> > >>> So is this needed as a fix or is this another clean-up?
> > >>> 
> > >>> So is this is really needed as a fix?
> > >> 
> > >> Hm. How do you differentiate between "fix" and "cleanup"?
> > >> Maybe it is more a wording than a content issue...
> > >> 
> > >> For me it is a "fix" because it is semantically wrong to have
> > >> a prefix where it is not needed. And "fixing" it changes the
> > >> compiler output by 8 bytes.
> > > 
> > > How about let's call it a "typo fix" then? :)
> > 
> > Well, it is not really a typo.
> 
> Well what if the stable people pick it into earlier stable series
> based on the word fix in the subject? That has happened before.
> 
> I suggest you update the dts patches to use wording like
> "update compatible to use new naming" or something similar.

Patch 4/4 is a Fix and should be applied to stable trees. "omapdss,"
prefix was never supposed to be in the DTS files, is not supposed to
be in there now and will break some time in the future.

Explanation: The early init of omapdss adds the prefix at runtime,
so that the binding can use generic properties and the kernel can
use omapdss specific drivers until the generic ones can be used.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171130/f6407f70/attachment.sig>
