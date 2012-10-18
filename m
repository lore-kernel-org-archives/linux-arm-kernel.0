From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 18 Oct 2012 03:46:15 +0000 (UTC)
Subject: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
In-Reply-To: <20121018030654.GE2867@netboy.at.omicron.at>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
Message-ID: <alpine.DEB.2.00.1210180313360.6893@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Oct 2012, Richard Cochran wrote:

> So there has been this cpsw driver since v3.4-rc1~177^2~5
> 
>    df82859 netdev: driver: ethernet: Add TI CPSW driver
> 
> and four people signed off on it, so it must have been working at one
> point.

The signoffs just mean that those people are asserting that the code is 
covered under an appropriate license, or are passing it on through the 
maintainer hierarchy.  See 

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=Documentation/SubmittingPatches;h=c379a2a6949f1c1cac04fb6f185c633512f37061;hb=HEAD#l298

It doesn't necessarily mean that the driver is usable in that kernel 
release.

> Since the device tree make-over, the driver is a derelict, and thus the 
> present patch is fixing a regression.

Probably the driver was submitted before any SoC integration support was 
available.  Grepping for 'cpsw' under arch/ turns up only AM33xx.  AM335x 
didn't have device enumeration support in the mainline kernel until 3.7, 
via commit a2cfc509bc4eeef9f5c4607b1203f17f22ea2a36 ("ARM: OMAP3+: hwmod: 
Add AM33XX HWMOD data").  So I don't see how it could have worked with 
mainline.

> I just want the already merged driver to work with the vanilla
> kernel. Is that too much to ask?

It's a very reasonable wish and your patches are certainly appreciated.

But it seems that the CPSW has never worked in the mainline kernel.  So 
this particular patch is not fixing a regression.  Therefore we shouldn't 
send it upstream during the -rc time period.  Instead we'll schedule it to 
be sent a few weeks later, during the 3.8 merge window.

Either way, the patch is likely to make it into the mainline kernel.  
It's just that it will probably take a few weeks longer than you might 
like.


- Paul
