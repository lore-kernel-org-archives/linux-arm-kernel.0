From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Mon, 9 Apr 2018 02:42:59 -0700
Subject: [PATCH v4] net: thunderx: rework mac addresses list to u64 array
In-Reply-To: <20180408.124200.2204489876311923873.davem@davemloft.net>
References: <20180406140443.15181-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180406195354.16037-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180408.124200.2204489876311923873.davem@davemloft.net>
Message-ID: <20180409094259.GA21694@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 08, 2018 at 12:42:00PM -0400, David Miller wrote:
> From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> Date: Fri,  6 Apr 2018 12:53:54 -0700
> 
> > @@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
> >  						  work.work);
> >  	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
> >  	union nic_mbx mbx = {};
> > -	struct xcast_addr *xaddr, *next;
> > +	int idx = 0;
> 
> No need to initialize idx.
> 
> > +		for (idx = 0; idx < vf_work->mc->count; idx++) {
> 
> As it is always explicitly initialized at, and only used inside of,
> this loop.

Ok, will post next version shortly.
Thanks for your time.

Vadim
