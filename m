From: mw@semihalf.com (Marcin Wojtas)
Date: Thu, 5 Jan 2017 15:07:02 +0100
Subject: [PATCHv2 0/5] Support for Marvell switches with integrated CPUs
In-Reply-To: <20170105130945.GA18033@lunn.ch>
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <6c6795d3-06ab-a4f0-78ad-5ecc78c1aa2f@gmail.com>
 <185147a37cab4d7eaea5f79d86cc9451@svr-chch-ex1.atlnz.lc>
 <20170105130945.GA18033@lunn.ch>
Message-ID: <CAPv3WKdsiGis6gG0SmLT1mg+LYA8i5p4u9KJiYJxng8jrLsj+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

2017-01-05 14:09 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
>> I'd love to see a switchdev driver but it's a huge task (and no I'm not
>> committing to writing it). As it stands Marvell ship a switch SDK
>> largely executes in userspace with a small kernel module providing some
>> linkage to the underlying hardware.
>
> Is there any similarity to the mv88e6xxx family?

Prestera switches (they are sold as standalone devices and with
integrated CPU's, like ones submitted) are as far from mv88e6xxx as
possible. There are various mix of 1/2.5/10/40G ports, depending on
model.

>
> If it was similar registers, just a different access mechanising, we
> could probably extend the mv88e6xxx to support MMIO as well as MDIO.
>

The difference is huge, nothing existing in the mainline can fit. The
driver, that exposes resources to the userspace SDK (called CPSS, it's
huge and complex piece of code) is existing in Marvell internal
branches (kernel v4.4 is the latest one), but I doubt such solution
(despite it's really small) is upstreamable. I believe it can be
shipped to the customers along with the SDK as a kernel module. Having
the CPU's support in the mainline is IMO sufficient.

Best regards,
Marcin
