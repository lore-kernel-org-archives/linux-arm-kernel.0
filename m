From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 22 Apr 2013 15:53:41 +0530
Subject: [PATCH 21/32] dmaengine: ste_dma40: Also report the number of
 logical channels
In-Reply-To: <20130422103715.GK3432@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-22-git-send-email-lee.jones@linaro.org>
 <20130422093631.GE24632@intel.com>
 <20130422101455.GH3432@gmail.com>
 <20130422094842.GL24632@intel.com>
 <20130422103715.GK3432@gmail.com>
Message-ID: <20130422102341.GV24632@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 11:37:15AM +0100, Lee Jones wrote:
> On Mon, 22 Apr 2013, Vinod Koul wrote:
> You only get a warning for this too:
Yup, oh i wrongly mention error
> 
>  WARNING: quoted string split across lines
> #33: FILE: drivers/dma/ste_dma40.c:3204:
> +	dev_info(&pdev->dev, "hardware revision: %d @ 0x%x with "
> +		"%d physical channels and %d logical channels\n",
> 
> > > How would you solve this?
> > Use common sense :) I would never sacrfice readablity of code. Erring on 80chars
> > is fine by me as long as it makes sense.
> 
> Common sense to me says split a string which goes over 100 chars. :)
agreed :)
> 
> ... and I don't think readability is compromised all that much, if at all.
I think if you start above at next line, you can be in 100chars and still be in
single line...
	dev_info(&pdev->dev,
		"hardware revision: %d @ 0x%x with %d physical channels and %d logical channels\n",
Plus a truncated one would help too...
s/revision/rev
s/channels/ch
etc

would bring this to saner levels :)

--
~Vinod
