From: treding@nvidia.com (Thierry Reding)
Date: Tue, 25 Aug 2015 11:15:36 +0200
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
Message-ID: <20150825091534.GB14034@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 23, 2015 at 06:23:14PM -0500, Rob Herring wrote:
> On Wed, Aug 19, 2015 at 9:50 AM, Yakir Yang <ykk@rock-chips.com> wrote:
[...]
> > +       -analogix,link-rate:
> > +               max link rate supported by the eDP controller.
> > +                       LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A,
> > +                       LINK_RATE_5_40GBPS = 0x14
> 
> Same here. I'd rather see something like "link-rate-mbps" and use the
> actual rate.

There is no need whatsoever to hard-code this in DT. (e)DP provides the
means to detect what rate the link supports and the specification
provides guidance on how to select an appropriate one.

> 
> > +       -analogix,lane-count:
> > +               max number of lanes supported by the eDP contoller.
> > +                       LANE_COUNT1 = 1, LANE_COUNT2 = 2, LANE_COUNT4 = 4
> 
> And drop the vendor prefix here.

Same as for the link rate.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150825/6f34dcce/attachment.sig>
