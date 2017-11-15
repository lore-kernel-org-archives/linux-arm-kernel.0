From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 15 Nov 2017 16:03:31 +0100
Subject: [PATCH v3 2/4] net: nb8800: Simplify nb8800_pause_config()
In-Reply-To: <01be0b9e-3d6c-bd1e-6b92-e2274ffeea5a@sigmadesigns.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <dd0c2014-8ef9-749c-16d3-6a56f4161658@sigmadesigns.com>
 <yw1x1sl12fx8.fsf@mansr.com>
 <569542b1-8e56-d7da-f7a0-affd89bfed62@sigmadesigns.com>
 <yw1xk1yt0zbp.fsf@mansr.com>
 <6f534b2b-f69a-bda5-dc5b-0281bf0df129@sigmadesigns.com>
 <20171115141707.GB2130@lunn.ch>
 <01be0b9e-3d6c-bd1e-6b92-e2274ffeea5a@sigmadesigns.com>
Message-ID: <20171115150331.GA29642@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 03:33:47PM +0100, Marc Gonzalez wrote:
> On 15/11/2017 15:17, Andrew Lunn wrote:
> 
> > nb8800_link_reconfigure() can be called whenever the link to the peer
> > changes. auto-neg may happen later because the cable was not plugged
> > in until later, etc.
> 
> Hello Andrew,
> 
> AFAICS, Mans was right: trying to toggle the flow control bit when
> the RX DMA bit is already set "breaks" the HW (ping times out).
> 
> Thus, I will drop patch 2/4.

O.K. Thanks for testing this.

> In our local branch, I have completely disabled flow control support,
> so I don't have to worry about this problem.

That is an interesting statement. You now know there is an issue here,
your solution is to fix your private branch and leave mainline as is.

     Andrew
