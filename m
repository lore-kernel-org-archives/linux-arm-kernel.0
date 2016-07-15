From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 15 Jul 2016 15:13:09 +0800
Subject: [PATCH v2 1/5] drivers: usb: chipidea: Add qoriq platform driver
In-Reply-To: <HE1PR0401MB2331ED4FB7F699A8A1BA0BE6E3300@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <1468038656-10345-1-git-send-email-rajesh.bhagat@nxp.com>
 <1468038656-10345-2-git-send-email-rajesh.bhagat@nxp.com>
 <20160711064358.GG31647@shlinux2>
 <HE1PR0401MB2331ED4FB7F699A8A1BA0BE6E3300@HE1PR0401MB2331.eurprd04.prod.outlook.com>
Message-ID: <20160715071309.GF817@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 03:59:07AM +0000, Rajesh Bhagat wrote:
> > > +
> > > +err_clks:
> > > +	ci_hdrc_qoriq_disable_unprepare_clks(pdev);
> > 
> > If you have only one clock, it is unnecessary to use dedicated APIs for clock operation.
> > 
> 
> We do have multiple clocks, but currently one is integrated in code. Hence created 
> the APIs for future use. 

If you could not integrate one more clocks, I suggest not creating dedicated
API until you need in future.

-- 

Best Regards,
Peter Chen
