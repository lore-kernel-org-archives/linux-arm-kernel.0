From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Tue, 30 Aug 2016 14:07:17 +0000
Subject: [PATCH v2 1/1] arm64: Add DTS support for FSL's LS1012A SoC
In-Reply-To: <20160830120220.GC8363@tiger>
References: <1472207241-18461-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <20160829095239.GM30790@tiger> <1472493061.13245.39.camel@buserror.net>
 <20160830120220.GC8363@tiger>
Message-ID: <HE1PR0401MB2636B40376255680B6A58CFB8DE00@HE1PR0401MB2636.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Tuesday, August 30, 2016 7:02 AM
> To: Scott Wood <oss@buserror.net>
> Cc: Bhaskar U <bhaskar.upadhaya@nxp.com>; devicetree at vger.kernel.org; Pratiyush Srivastava
> <pratiyush.srivastava@nxp.com>; Stuart Yoder <stuart.yoder@nxp.com>; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>; linux-devel at gforge.freescale.net; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 1/1] arm64: Add DTS support for FSL's LS1012A SoC
> 
> On Mon, Aug 29, 2016 at 12:51:01PM -0500, Scott Wood wrote:
> > On Mon, 2016-08-29 at 17:52 +0800, Shawn Guo wrote:
> > > On Fri, Aug 26, 2016 at 03:57:21PM +0530, Bhaskar Upadhaya wrote:
> > > >
> > > > +		clockgen: clocking at 1ee1000 {
> > > > +			compatible = "fsl,ls1012a-clockgen";
> > > The compatible cannot be found in binding docs.
> >
> > From?Documentation/devicetree/bindings/clock/qoriq-clock.txt:
> >
> > - compatible: Should contain a chip-specific clock block compatible
> > ????????string and (if applicable) may contain a chassis-version clock
> > ????????compatible string.
> >
> > ? ? ? ? Chip-specific strings are of the form "fsl,<chip>-clockgen", such as:
> > ????????* "fsl,p2041-clockgen"
> > ????????* "fsl,p3041-clockgen"
> > ????????* "fsl,p4080-clockgen"
> > ????????* "fsl,p5020-clockgen"
> > ????????* "fsl,p5040-clockgen"
> > ????????* "fsl,t4240-clockgen"
> > ????????* "fsl,b4420-clockgen"
> > ????????* "fsl,b4860-clockgen"
> > ????????* "fsl,ls1021a-clockgen"
> > ????????Chassis-version clock strings include:
> > ????????* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
> > ????????* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
> >
> > I really hope we don't have to update every single fsl,<chip>-whatever binding
> > every time a new chip comes out. ?There are already other chips not listed,
> > FWIW (e.g. t1040, t2080, ls1043a, and ls2080a). ?That's why it says "such as".
> 
> If I remember correctly, DT maintainers want every supported compatible
> string explicitly listed in bindings doc.  And they even added a check
> into checkpatch.pl with commit bff5da433525 ("checkpatch: add DT
> compatible string documentation checks").

See Documentation/devicetree/bindings/submitting-patches.txt:

  5) The wildcard "<chip>" may be used in compatible strings, as in
     the following example:

         - compatible: Must contain '"nvidia,<chip>-pcie",
           "nvidia,tegra20-pcie"' where <chip> is tegra30, tegra132, ...

     As in the above example, the known values of "<chip>" should be
     documented if it is used.

It _is_ allowed to use the <chip> wildcard, and so you will not find all
full compatible strings explicitly listed in bindings.  However, the
chips themselves "should" be listed.

Thanks,
Stuart
