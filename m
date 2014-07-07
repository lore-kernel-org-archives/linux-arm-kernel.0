From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 7 Jul 2014 21:44:06 +0200
Subject: [PATCH 1/5] memory: add a driver for atmel ram controllers
In-Reply-To: <20140707183340.GG9558@ns203013.ovh.net>
References: <1404746355-19988-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1404746355-19988-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20140707183340.GG9558@ns203013.ovh.net>
Message-ID: <20140707194406.GH3113@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2014 at 20:33:40 +0200, Jean-Christophe PLAGNIOL-VILLARD wrote :
> > +	if (caps->has_mpddr_clk) {
> > +		clk = devm_clk_get(&pdev->dev, "mpddr");
> > +		if (WARN_ON(IS_ERR(clk)))
> > +			return 0;
> 		I don't like this warn_on this need to be an error

What would you prefer ? pr_err() and panic or BUG_ON ?. We can also
probably simply put a single pr_err(), anyway, the platform will stop
just before switching to userspace.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
