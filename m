From: madalin.bucur@nxp.com (Madalin-cristian Bucur)
Date: Mon, 19 Nov 2018 07:11:00 +0000
Subject: [PATCH v2 2/2] dpaa_eth: add ethtool coalesce control
In-Reply-To: <20181116.194219.2027125174407236599.davem@davemloft.net>
References: <1542126591-5114-1-git-send-email-madalin.bucur@nxp.com>
 <1542126591-5114-3-git-send-email-madalin.bucur@nxp.com>
 <20181116.194219.2027125174407236599.davem@davemloft.net>
Message-ID: <DB7PR04MB400914664928CDCD6797F151ECD80@DB7PR04MB4009.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: David Miller <davem@davemloft.net>
> Sent: Saturday, November 17, 2018 5:42 AM
> To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
> Subject: Re: [PATCH v2 2/2] dpaa_eth: add ethtool coalesce control
> 
> From: Madalin Bucur <madalin.bucur@nxp.com>
> Date: Tue, 13 Nov 2018 18:29:51 +0200
> 
> > +	for_each_cpu(cpu, cpus) {
> > +		portal = qman_get_affine_portal(cpu);
> > +		res = qman_portal_set_iperiod(portal, period);
> > +		if (res)
> > +			return res;
> > +		res = qman_dqrr_set_ithresh(portal, thresh);
> > +		if (res)
> > +			return res;
> 
> Nope, you can't do it like this.
> 
> If any intermediate change fails, you have to unwind all of the
> changes made up until that point.
> 
> Which means you'll have to store the previous setting somewhere
> and reinstall those saved values in the error path.

Thank you, I'll come back with a v3.

Madalin
