From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 16 Jun 2010 09:10:42 -0600
Subject: [PATCH 12/12] ptp: Added a clock driver for the National
	Semiconductor PHYTER.
In-Reply-To: <20100616100539.GA3569@riccoc20.at.omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<37f5015b186bdd51f8451ade042f90c8b39a5cc8.1276615626.git.richard.cochran@omicron.at>
	<AANLkTilqd-wxqMWDxssC-XMDJqZ8iIiSrvp2t8xARAQV@mail.gmail.com>
	<20100616100539.GA3569@riccoc20.at.omicron.at>
Message-ID: <AANLkTilYBL6gpeg5Yp0wOmqwIo3K5YKW4mtVlE2p6jkp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 16, 2010 at 4:05 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Tue, Jun 15, 2010 at 12:49:13PM -0600, Grant Likely wrote:
>> Won't this break things for existing DP83640 users?
>
> Nope, the driver was only added five patches ago, and it only offers
> the timestamping stuff. The standard PHY functions just call the
> generic functions, so the PHY works fine even without this driver.
>
>> > +static struct ptp_clock *dp83640_clock;
>> > +DEFINE_SPINLOCK(clock_lock); /* protects the one and only dp83640_clock */
>>
>> Why only one? ?Is it not possible to have 2 of these PHYs in a system?
>
> Yes, you can have multiple PHYs, but only one PTP clock.
>
> If you do use multiple PHYs, then you must wire their clocks together
> and adjust the PTP clock on only one of the PHYs.
>
>
> Thanks for your other comments,

You're welcome.  Make sure to cc: linux-kernel on your next posting.
I commented on what I could, but there is a lot of code outside my
areas of expertise.  In particular the time keeping code needs to be
looked at by the maintainers in that area.

Cheers,
g.
