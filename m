From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Mar 2017 17:32:54 +0000
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170311153229.yrdjmggb3p2suhdw@ihha.localdomain>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-15-git-send-email-steve_longerbeam@mentor.com>
 <20170302160257.GK3220@valkosipuli.retiisi.org.uk>
 <20170303230645.GR21222@n2100.armlinux.org.uk>
 <20170304131329.GV3220@valkosipuli.retiisi.org.uk>
 <a7b8e095-a95c-24bd-b1e9-e983f18061c4@xs4all.nl>
 <20170310120902.1daebc7b@vento.lan>
 <5e1183f4-774f-413a-628a-96e0df321faf@xs4all.nl>
 <20170311101408.272a9187@vento.lan>
 <20170311153229.yrdjmggb3p2suhdw@ihha.localdomain>
Message-ID: <20170311173254.GC21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 11, 2017 at 05:32:29PM +0200, Sakari Ailus wrote:
> My understanding of the i.MX6 case is the hardware is configurable enough
> to warrant the use of the Media controller API. Some patches indicate
> there are choices to be made in data routing.

The iMX6 does have configurable data routing, but in some scenarios
(eg, when receiving bayer data) there's only one possible routing.

> Steve: could you enlighten us on the topic, by e.g. doing media-ctl
> --print-dot and sending the results to the list? What kind of different IP
> blocks are there and what do they do? A pointer to hardware documentation
> wouldn't hurt either (if it's available).

Attached for the imx219 camera.  Note that although the CSI2 block has
four outputs, each output is dedicated to a CSI virtual channel, so
they can not be arbitarily assigned without configuring the sensor.

Since the imx219 only produces bayer, the graph is also showing the
_only_ possible routing for the imx219 configured for CSI virtual
channel 0.

The iMX6 manuals are available on the 'net.

	https://community.nxp.com/docs/DOC-101840

There are several chapters that cover the capture side:

* MIPI CSI2
* IPU CSI2 gasket
* IPU

The IPU not only performs capture, but also display as well.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx219.dot
Type: text/vnd.graphviz
Size: 4557 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170311/dfafb712/attachment.dot>
