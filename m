From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 15 Mar 2017 23:46:47 +0100
Subject: [PATCH v4 00/18] add support for AXP20X and AXP22X power supply
 drivers
In-Reply-To: <bc829791-c543-220a-8c42-1023b1a82963@free-electrons.com>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315121450.bl5dxdjzazwsrvni@dell>
 <bc829791-c543-220a-8c42-1023b1a82963@free-electrons.com>
Message-ID: <20170315224647.suhnptpczykuoffd@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 02:18:56PM +0100, Quentin Schulz wrote:
> Hi Lee,
> 
> On 15/03/2017 13:14, Lee Jones wrote:
> > On Wed, 15 Mar 2017, Quentin Schulz wrote:
> > 
> >> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose
> >> information and data of the various power supplies they support such as
> >> ACIN, battery and VBUS. For example, they expose the current battery
> >> voltage, charge or discharge, as well as ACIN and VBUS current voltages
> >> and currents, internal PMIC temperature and ADC on 2 different GPIOs
> >> when in the right mode (for the AXP209 only).
> > 
> > What are you missing from this set now?  What Acks etc?  And what's
> > the plan with regards to route to Mainline?  Where are the dependencies
> > etc?
> > 
> 
> Basically, a consensus on how we should named the DT property I added in
> patch 01 and 02 (which is used afterwards in battery driver). All other
> patches have ACKs.
> 
> I added some logic to the battery driver so if anyone wants to review
> that you're welcome. I already got several ACKs from the v3 though.
> 
> No dependencies except for the battery driver (and the first two
> patches) which needs the battery "framework" in the Power Supply
> subsystem. A v9 of this framework has been sent a little bit more than a
> week ago, I need this to be merged first or the battery driver will just
> not compile. I think the other patches are ready to be merged.

FWIW I expect, that the axp battery patches go through my tree, since
there doesn't seem to be a compile time dependency to the other
patches from this series nor vice versa. I'm aware of the dependency
to the bq27xxx series of course.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/fc960d23/attachment.sig>
