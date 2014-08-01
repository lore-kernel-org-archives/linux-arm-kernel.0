From: balbi@ti.com (Felipe Balbi)
Date: Fri, 1 Aug 2014 08:54:07 -0500
Subject: [PATCH 29/35] arm: omap: intc: switch over to linear irq domain
In-Reply-To: <53DB877A.5000004@ti.com>
References: <20140729154057.GE17808@saruman.home>
 <20140729163345.GF17808@saruman.home>
 <20140730060420.GY29045@atomide.com>
 <20140730144059.GA7272@saruman.home>
 <CAGo_u6ou+MoKOE_tTTmjxyFNW=jTaN9vnTsHrxR6sQHsieJyLA@mail.gmail.com>
 <20140730162038.GH7272@saruman.home>
 <20140731062843.GA29045@atomide.com> <53D9F6D5.1080307@ti.com>
 <20140731134945.GB19512@saruman.home> <53DB877A.5000004@ti.com>
Message-ID: <20140801135407.GB9216@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 01, 2014 at 03:26:34PM +0300, Tero Kristo wrote:
> >>>>>>I might have sent the wrong version as I had that same build error and
> >>>>>>fixed it localy.
> >>>>>>
> >>>>>>>it fixes the regression for me, Also now the whole series works for
> >>>>>>>me :)
> >>>>>>
> >>>>>>good to know.
> >>>>>>
> >>>>>>What do you want to do now ? Wait for PRCM to become a driver ? Wait for
> >>>>>>Nishanth's series to get accepted ? I guess the same thing could be done
> >>>>>>for OMAP3 and AM33, then we would have a chance of having working wake
> >>>>>>from idle with the new irqchip.
> >>>>>
> >>>>>I can repost the current series as it stands now once 17-rc1 comes out
> >>>>>(without the build failure ofcourse).. if that helps to move it out of
> >>>>>RFC status.
> >>>>
> >>>>That'd be great. It would be ever greater if you could add support for
> >>>>OMAP3 on that too.
> >>>
> >>>Yeah sounds good to me. Tero, does that work OK for your PRCM changes?
> >>
> >>Well, this set seems to break PM. suspend-resume on omap3-beagle just hangs
> >>after this set is applied. Works fine without it with 3.16-rc5 tag.
> >
> >did you apply the quick little hack to prm3xxx.c ? prcm IRQ is hardcoded
> >to 11, once we switch to a linear irq domain, irq_base may change.
> 
> Yea, with that hack it works. However, you should make that into a proper
> patch and add it to this series, otherwise you will be causing regressions.

can you please read the thread ? Nishanth has a proper series properly
doing that for OMAP4, I asking him to add OMAP3 and respin his series
without RFC.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140801/eee3ae0d/attachment.sig>
