From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 15 Nov 2017 22:12:27 +0100
Subject: [PATCH v3 2/4] net: nb8800: Simplify nb8800_pause_config()
In-Reply-To: <e3dfc32f-7052-603d-659a-0a7d9d7453b0@sigmadesigns.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <dd0c2014-8ef9-749c-16d3-6a56f4161658@sigmadesigns.com>
 <yw1x1sl12fx8.fsf@mansr.com>
 <569542b1-8e56-d7da-f7a0-affd89bfed62@sigmadesigns.com>
 <yw1xk1yt0zbp.fsf@mansr.com>
 <6f534b2b-f69a-bda5-dc5b-0281bf0df129@sigmadesigns.com>
 <20171115141707.GB2130@lunn.ch>
 <01be0b9e-3d6c-bd1e-6b92-e2274ffeea5a@sigmadesigns.com>
 <20171115150331.GA29642@lunn.ch>
 <e3dfc32f-7052-603d-659a-0a7d9d7453b0@sigmadesigns.com>
Message-ID: <20171115211227.GE29642@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 04:19:56PM +0100, Marc Gonzalez wrote:
> On 15/11/2017 16:03, Andrew Lunn wrote:
> 
> > On Wed, Nov 15, 2017 at 03:33:47PM +0100, Marc Gonzalez wrote:
> > 
> >> On 15/11/2017 15:17, Andrew Lunn wrote:
> >>
> >> In our local branch, I have completely disabled flow control support,
> >> so I don't have to worry about this problem.
> > 
> > That is an interesting statement. You now know there is an issue here,
> > your solution is to fix your private branch and leave mainline as is.
> 
> All my patches are NACKed, what would you have me do?

Hi Marc

You need to consider your own maintenance burden. You want your local
branch to be as near to mainline as possible. Each change you have
means additional maintenance work for you. It also possibly means
additional work for your customers.

You seem to think flow control in your hardware is too broken to be
usable. So you probably want to submit a patch to mainline disabling
it. If it is accepted, that is one less patch you need to maintain.

    Andrew
