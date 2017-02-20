From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Feb 2017 17:57:43 +0000
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20170220175331.GC963@e110455-lin.cambridge.arm.com>
References: <20161118233733.GP1041@n2100.armlinux.org.uk>
 <20170220121603.GA1132@n2100.armlinux.org.uk>
 <20170220175331.GC963@e110455-lin.cambridge.arm.com>
Message-ID: <20170220175743.GQ21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 05:53:31PM +0000, Liviu Dudau wrote:
> Sorry, looks like this fell through the cracks of us trying to fix the
> other issues you were seeing. I'm attaching a patch, please let me know
> if this works for you.

I don't have time to test right now, but it looks similar to what I
had.

Only nit is - is dest_w used apart from being written once?  (That's
probably something for a separate patch.)

There's also the issue which Daniel Vetter followed up with to my
comment about this calculation - the plane state validation is
insufficient, and it would be a good idea if it used
drm_plane_helper_check_state().

Also, I've since noticed that it doesn't check state->rotation, and
I don't think this driver supports any rotation options.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
