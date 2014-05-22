From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 22 May 2014 12:22:09 +0200
Subject: [PATCH v3] clk: shmobile: Add R8A7740-specific clock support
In-Reply-To: <CANqRtoQtPnUcGCg4X9UuNoA6pg6Vd7HWfo30LqD1LOUi+5VC-A@mail.gmail.com>
References: <1400682086-5705-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1768296.AYVfH6xHtk@avalon>
 <CANqRtoQtPnUcGCg4X9UuNoA6pg6Vd7HWfo30LqD1LOUi+5VC-A@mail.gmail.com>
Message-ID: <2463693.SJ3Ug7SyHp@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Thursday 22 May 2014 09:37:40 Magnus Damm wrote:
> On Thu, May 22, 2014 at 12:41 AM, Laurent Pinchart wrote:
> > On Wednesday 21 May 2014 16:21:26 Ulrich Hecht wrote:
> >> Driver for the R8A7740's clocks that are too specific to be supported by
> >> a generic driver.
> >> 
> >> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > 
> > The implementation looks globally sane to me. There's still quite a few
> > missing clocks, but there's no hurry in adding support for them at the
> > moment. I'd like to get the bindings reviewed by someone outside of our
> > team, but that would require making the CPG documentation (or at least
> > the block diagram) available. Magnus, is there a chance for that to
> > happen ?
> 
> Regarding documentation, as much as I'd like to see this, in practice it
> feels highly unlikely since I'm not in control of the actual data sheet
> distribution policy. I believe Emma Mobile series data sheet are available
> for public download, but the rest of the SoCs are not unfortunately.
> 
> This issue with closed documentation is not specific to r8a7740 though, so
> earlier developed CCF implementations included in upstream like r8a7790,
> r8a7791, r7s72100 and r8a7779 are in the same state as r8a7740.

Yes they are, although the hardware is simpler in those cases, so there's less 
potential issues. I don't have a specific concern here, just a feeling of 
uneasiness coming from publishing DT bindings that can't be properly reviewed 
by someone out of our team. We're too familiar with the hardware to take a 
step back and see the bindings from an external point of view, which is why 
I'd like an external review before committing to any DT binding stability.

There's of course no reason to delay this patch (well, except for all the 
other small comments I've made :-)), but if it were me I would mark the 
corresponding bindings with a big "EXPERIMENTAL" warning.

-- 
Regards,

Laurent Pinchart
