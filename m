From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 14 Jul 2014 12:18:08 +0200
Subject: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
In-Reply-To: <20140711140025.62873695@bbrezillon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1584022.nQ4HpIUW7J@avalon> <20140710145626.48cb956f@bbrezillon>
 <33456066.4Q4p6nxKdU@avalon> <20140711140025.62873695@bbrezillon>
Message-ID: <20140714101807.GC9870@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 02:00:25PM +0200, Boris BREZILLON wrote:
> On Fri, 11 Jul 2014 12:37:46 +0200 Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> > On Thursday 10 July 2014 14:56:26 Boris BREZILLON wrote:
[...]
> > > BTW, is there any reason for not defining an RGB connector type (I'm
> > > currently defining HLCDC connector as an LVDS connector) ?
> > 
> > Not that I know of. The DRM API has been developed before display on embedded 
> > systems became such a hot topic. If we had to redo it today, panels might be 
> > exposed to userspace as such, with a connector. We have to live with the past, 
> > so the connector will stay, but adding a new RGB connector type could make 
> > sense (although we might need a different name, in a way the VGA and LVDS 
> > connectors also carry RGB signals).
> 
> I had the same concern: I didn't find how this kind of connectors
> was named (most of the time they're just referenced as RGB) :-).
> What about RAW_RGB ?

Are there even panels that take raw RGB as input? In all cases I've seen
(which admittedly may not be all that many) there's always a transparent
RGB/LVDS bridge, so the "connector" is in fact LVDS, not RGB, even if
the display controller outputs RGB directly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/cadcc8c0/attachment-0001.sig>
