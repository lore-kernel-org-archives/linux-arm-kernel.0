From: treding@nvidia.com (Thierry Reding)
Date: Tue, 25 Aug 2015 16:21:51 +0200
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <55DC75C8.209@rock-chips.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <20150825095817.GC14034@ulmo.nvidia.com>
 <55DC75C8.209@rock-chips.com>
Message-ID: <20150825142150.GB3820@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 10:03:52PM +0800, Yakir Yang wrote:
> Hi Thierry,
> 
> ? 2015/8/25 17:58, Thierry Reding ??:
> >On Wed, Aug 19, 2015 at 09:50:34AM -0500, Yakir Yang wrote:
> >[...]
> >>+	-analogix,color-space:
> >>+		input video data format.
> >>+			COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2
> >I don't think DT is an appropriate place to set this. To my knowledge
> >this depends on the display and/or mode, so I don't think hard-coding
> >it here is the right thing to do.
> 
> Yeah, same question with my previous reply ;)

I don't have an answer for you, unfortunately. But like I said,
hard-coding isn't going to work. What if, for example, you set this to a
fixed value and then you connect a monitor that doesn't support the
specific one you set?

You cited code from dw_hdmi.c earlier, it looks like it might be correct
even though it doesn't cite a reference for why this was done. Perhaps
someone on this thread, or someone involved with dw_hdmi can answer
where that code came from.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150825/79ae0ecb/attachment.sig>
