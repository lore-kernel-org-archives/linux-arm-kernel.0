From: oss@buserror.net (Scott Wood)
Date: Mon, 06 Aug 2018 19:13:49 -0500
Subject: [PATCH v2 6/6] fsl_pmc: update device bindings
In-Reply-To: <20180416151356.r7si6higfrovl53l@rob-hp-laptop>
References: <20180411063551.30368-1-ran.wang_1@nxp.com>
 <20180411063551.30368-6-ran.wang_1@nxp.com>
 <20180416151356.r7si6higfrovl53l@rob-hp-laptop>
Message-ID: <fe49ef59e93842c6f2beabd130918c9262cef9fe.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-04-16 at 10:13 -0500, Rob Herring wrote:
> On Wed, Apr 11, 2018 at 02:35:51PM +0800, Ran Wang wrote:
> > From: Li Yang <leoli@freescale.com>
> 
> Needs a commit msg and the subject should give some indication of what 
> the update is. And also start with "dt-bindings: ..."

This patch should also come before the patches that use the new binding.

> > -  fsl,mpc8536-pmc: Sleep specifiers consist of three cells, the third of
> > -  which will be ORed into PMCDR upon suspend, and cleared from PMCDR
> > -  upon resume.  The first two cells are as described for fsl,mpc8578-pmc.
> > -  This sleep controller only supports disabling devices during system
> > -  sleep, or permanently.
> > -
> > -  fsl,mpc8548-pmc: Sleep specifiers consist of one or two cells, the
> > -  first of which will be ORed into DEVDISR (and the second into
> > -  DEVDISR2, if present -- this cell should be zero or absent if the
> > -  hardware does not have DEVDISR2) upon a request for permanent device
> > -  disabling.  This sleep controller does not support configuring devices
> > -  to disable during system sleep (unless supported by another compatible
> > -  match), or dynamically.
> 
> You seem to be breaking backwards compatibility with this change. I 
> doubt that is okay on these platforms.

I don't think the sleep specifier stuff ever got used.

-Scott
