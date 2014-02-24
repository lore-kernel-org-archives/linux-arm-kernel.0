From: phdm@macq.eu (Philippe De Muyter)
Date: Mon, 24 Feb 2014 09:25:23 +0100
Subject: [PATCH v5] bus: imx-weim: support CS GPR configuration
In-Reply-To: <20140224020455.GA25457@S2101-09.ap.freescale.net>
References: <1392705666-10995-1-git-send-email-shawn.guo@linaro.org>
 <20140224020455.GA25457@S2101-09.ap.freescale.net>
Message-ID: <20140224082523.GA14927@frolo.macqel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 10:04:59AM +0800, Shawn Guo wrote:
> On Tue, Feb 18, 2014 at 02:41:06PM +0800, Shawn Guo wrote:
> > For imx50-weim and imx6q-weim type of devices, there might a WEIM CS
> > space configuration register in General Purpose Register controller,
> > e.g. IOMUXC_GPR1 on i.MX6Q.
> > 
> > Depending on which configuration of the following 4 is chosen for given
> > system, IOMUXC_GPR1[11:0] should be set up as 05, 033, 0113 or 01111
> > correspondingly.
> > 
> > 	CS0(128M) CS1(0M)  CS2(0M)  CS3(0M)
> > 	CS0(64M)  CS1(64M) CS2(0M)  CS3(0M)
> > 	CS0(64M)  CS1(32M) CS2(32M) CS3(0M)
> > 	CS0(32M)  CS1(32M) CS2(32M) CS3(32M)
> > 
> > The patch creates a function for such type of devices, which scans
> > 'ranges' property of WEIM node and build the GPR value incrementally.
> > Thus the WEIM CS GPR can be set up automatically at boot time.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Philippe,
> 
> Any further comments?  Or can I have your Reviewed-by or Tested-by tag?

Yep, sorry. of course :

Reviewed-by: Philippe De Muyter <phdm@macqel.be>
Tested-by: Philippe De Muyter <phdm@macqel.be>

And also a 'thank you, Shawn'

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
