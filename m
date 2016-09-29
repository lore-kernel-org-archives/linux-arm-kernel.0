From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 29 Sep 2016 14:04:45 +0200
Subject: [PATCH] drm/sun4i: rgb: Enable panel after controller
In-Reply-To: <CAOw6vbKxJeSZYsCwVWYbVosZUK+FfBq1ytrpRUNpbH+kM6Ow6Q@mail.gmail.com>
References: <20160921130304.3486-1-net147@gmail.com>
 <20160921210340.GI8719@lukather>
 <CANwerB2pmO7AMqmE9SMR1vFFsY5jMUALGSvtd=AvpU1=_jSHUw@mail.gmail.com>
 <20160923131626.GX8719@lukather>
 <CANwerB1PgaACukEj1jzUY-dQzbf50Em3h47KEsQu3rC3Jej=6Q@mail.gmail.com>
 <20160924201813.GE16901@lukather>
 <CAOw6vbKxJeSZYsCwVWYbVosZUK+FfBq1ytrpRUNpbH+kM6Ow6Q@mail.gmail.com>
Message-ID: <20160929120445.GQ4189@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 27, 2016 at 10:42:09AM -0400, Sean Paul wrote:
> As an aside, it seems like (from the diff, I haven't looked at the
> code) the bridge_pre_enable and bridge_post_disable calls are missing,
> and the enable/disable calls are in the wrong place.

Actually, I don't even think that's necessary. The atomic helpers
already call drm_bridge_pre_enable and drm_bridge_enable at the right
time. So I guess the proper fix would be to just remove the driver's
call to drm_bridge_enable.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160929/7c5646a7/attachment.sig>
