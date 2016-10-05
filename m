From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Wed, 5 Oct 2016 12:23:15 +0000
Subject: [PATCH v5] devicetree: bindings: uart: Add new compatible
 string for ZynqMP
In-Reply-To: <20161003184234.GA13165@rob-hp-laptop>
References: <1474898801-36571-1-git-send-email-navam@xilinx.com>
 <20161003184234.GA13165@rob-hp-laptop>
Message-ID: <C89496FEAE474D468F30D558A9468D9F26D2AB89@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

	Thanks for the review...

> > Changes for v5:
> > 		-Fixed some minor comments.
> 
> Not a useful changelog. The point of these comments is to remind the
> reviewers of what they commented on.

Ok will take care from next version onwards...

> >  Required properties:
> > -- compatible : should be "cdns,uart-r1p8", or "xlnx,xuartps"
> > +- compatible :
> > +  Use "cdns,uart-r1p8", or "xlnx,xuartps" for Zynq-7xxx SoC.
> 
> This is still not right. It was wrong before, but you are touching it so make it
> right.
> 
> OR doesn't match the dts files. It is AND and the opposite order.
> 
> xlnx,xuartps wasn't the best naming, but it's in use so we'll have to live with it
> for zynq-7xxx.
> 
> > +  Use "cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC.
> 
> What I meant here was this should have something like "xlnx,mpsoc-uart"
> as the first compatible with "cdns,uart-r1p12" as the second. Not sure if
> "mpsoc" is the best name here.

You mean something like below
 Use "xlnx,xuartps" or "cdns,uart-r1p8" for Zynq-7xxx SoC.
Use "xlnx,zynqmp-uart" or " cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC.

Please correct me if my understanding is wrong.

Regards,
Navakishore.
