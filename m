From: sre@ring0.de (Sebastian Reichel)
Date: Fri, 28 Feb 2014 17:25:05 +0100
Subject: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <5310B567.7040605@ti.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
 <20140228155937.GQ21483@n2100.arm.linux.org.uk>
 <5310B567.7040605@ti.com>
Message-ID: <20140228162504.GB29034@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 06:12:23PM +0200, Tomi Valkeinen wrote:
> On 28/02/14 17:59, Russell King - ARM Linux wrote:
> 
> >> +dvi0: connector at 0 {
> >> +	compatible = "dvi-connector";
> >> +	label = "dvi";
> >> +
> >> +	i2c-bus = <&i2c3>;
> >> +
> >> +	dvi_connector_in: endpoint {
> >> +		remote-endpoint = <&tfp410_out>;
> >> +	};
> >> +};
> > 
> > This looks far too simplistic.  There are different classes of DVI
> > connector - there is:
> > 
> > DVI A - analogue only
> > DVI D - digital only (single and dual link)
> > DVI I - both (single and dual digital link)
> > 
> > DRM at least makes a distinction between these three classes, and this
> > disctinction is part of the user API.  How would a display system know
> > which kind of DVI connector is wired up on the board from this DT
> > description?
> 
> Yes, I think that's a valid change. But do we also need to specify
> single/dual link, in addition to the three types?
> 
> I guess the compatible string is the easiest way for differentation, at
> least for the three main types, i.e. "dvi-d-connector" etc.
> 
> "dvi-d-1l-connector" and "dvi-d-2l-connector" for the single/dual link?
> That looks a bit funny.

maybe like this:

Required Properties:
 - compatible: should contain one of the following:
  * "dvi-d-connector"
  * "dvi-a-connector"
  * "dvi-i-connector"

Optional Properties:
 - dual-link: Should be set for dual-link capable connectors

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/91551572/attachment.sig>
