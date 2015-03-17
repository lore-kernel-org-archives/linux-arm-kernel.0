From: agross@codeaurora.org (Andy Gross)
Date: Tue, 17 Mar 2015 00:04:15 -0500
Subject: [Patch v4 2/2] dmaengine: Add ADM driver
In-Reply-To: <11135b79b94477532e57f30b1ea3c715.squirrel@www.codeaurora.org>
References: <1423719965-8156-1-git-send-email-agross@codeaurora.org>
 <1423719965-8156-3-git-send-email-agross@codeaurora.org>
 <20150313085745.GG32000@intel.com>
 <20150313220627.GB23640@qualcomm.com>
 <11135b79b94477532e57f30b1ea3c715.squirrel@www.codeaurora.org>
Message-ID: <20150317050415.GB28722@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 08:15:26AM -0000, sricharan at codeaurora.org wrote:
> Hi,
> 
> <snip>
> >
> >>
> >> > +static int adm_get_blksize(unsigned int burst)
> >> > +{
> >> > +	int ret;
> >> > +
> >> > +	switch (burst) {
> >> > +	case 16:
> >> > +		ret = 0;
> >> > +		break;
> >> > +	case 32:
> >> > +		ret = 1;
> >> > +		break;
> >> > +	case 64:
> >> > +		ret = 2;
> >> > +		break;
> >> > +	case 128:
> >> > +		ret = 3;
> >> > +		break;
> >> > +	case 192:
> >> > +		ret = 4;
> >> > +		break;
> >> > +	case 256:
> >> > +		ret = 5;
> >> > +		break;
> >> ffs(burst>>4) ?
> >
> > that should work nicely.  thanks.
> >
>   Will not work for 192, 256 ?

you are right.  I'll have to separate those out into 2 more cases.  Good catch!

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
