From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Jan 2013 10:40:44 +0000
Subject: Failure to boot...
In-Reply-To: <20130131092024.GN2637@n2100.arm.linux.org.uk>
References: <20130131014912.GM2637@n2100.arm.linux.org.uk>
 <20130131030203.GA8374@quad.lixom.net>
 <alpine.LFD.2.02.1301302312030.6300@xanadu.home>
 <20130131092024.GN2637@n2100.arm.linux.org.uk>
Message-ID: <20130131104044.GO2637@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 09:20:24AM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 30, 2013 at 11:19:40PM -0500, Nicolas Pitre wrote:
> > Better yet (IMHO): just enable the zboot command in U-Boot to let you 
> > boot a zImage binary directly.
> 
> I wish it were that easy but it isn't.  I've no idea where to get a
> version of uboot for my boards which supports that; TI have always
> supplied updates to uboot for me, and with the current state of TI
> being afaict in chaos.
> 
> TI have always supplied a replacement X-Loader with each uboot update.
> I've no idea what X-Loader is or why both get updated together, but...
> 
> Moreover, I doubt that the 3430LDP, of which there are multiple versions,
> will ever see a uboot update.  It already suffers from a lack of correct
> kernel support due to random wiring changes between these versions (the
> keypad doesn't work correctly) and I've yet to indentify which version
> it is despite downloading the circuits.  So trying to locate the right
> uboot will be impossible there.
> 
> So, I'm _stuck_ with uImages for these platforms.

Right, so I'm now passing LOADADDR= which allows this to work - and the
latest OMAP4430SDP boot result shows almost the same sad broken story.
