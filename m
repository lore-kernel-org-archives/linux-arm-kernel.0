From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 20 Feb 2017 17:53:31 +0000
Subject: [BUG] hdlcd gets confused about base address
In-Reply-To: <20170220121603.GA1132@n2100.armlinux.org.uk>
References: <20161118233733.GP1041@n2100.armlinux.org.uk>
 <20170220121603.GA1132@n2100.armlinux.org.uk>
Message-ID: <20170220175331.GC963@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Feb 20, 2017 at 12:16:03PM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 18, 2016 at 11:37:33PM +0000, Russell King - ARM Linux wrote:
> > Something I also noticed is this:
> > 
> >         scanout_start = gem->paddr + plane->state->fb->offsets[0] +
> >                 plane->state->crtc_y * plane->state->fb->pitches[0] +
> >                 plane->state->crtc_x * bpp / 8;
> > 
> > Surely this should be using src_[xy] (which are the position in the
> > source - iow, memory, and not crtc_[xy] which is the position on the
> > CRTC displayed window.  To put it another way, the src_* define the
> > region of the source material that is mapped onto a rectangular area
> > on the display defined by crtc_*.
> 
> This problem still exists...

Sorry, looks like this fell through the cracks of us trying to fix the
other issues you were seeing. I'm attaching a patch, please let me know
if this works for you.

Best regards,
Liviu

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-arm-hdlcd-Fix-the-calculation-of-scanout-start-addre.patch
Type: text/x-diff
Size: 1635 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170220/c264b8a0/attachment.bin>
