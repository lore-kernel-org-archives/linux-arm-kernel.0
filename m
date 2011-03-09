From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 Mar 2011 10:15:08 +0000
Subject: [PATCH 2/3] ARM: tegra: harmony: initialize the TPS65862 PMIC
In-Reply-To: <4D772F23.70304@compulab.co.il>
References: <cover.1299588456.git.mike@compulab.co.il>
	<4ade6d195fff78271085eafb0a99de3be8beb426.1299588456.git.mike@compulab.co.il>
	<20110308131541.GB5892@sirena.org.uk>
	<4D772F23.70304@compulab.co.il>
Message-ID: <20110309101508.GD6923@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2011 at 09:41:23AM +0200, Mike Rapoport wrote:
> On 03/08/11 15:15, Mark Brown wrote:

> > I feel sure that some of these could be using a struct device, though
> > since they're probably all going to be required to be always on I'd
> > expect it's not useful to have them mapped as supplies at all and the
> > drivers could just assume they were there.

> I'd prefer to keep it as is for now and update the supplies when merging the
> drivers that actually use them.

There's no point in keepig them if they don't match up with the actual
drivers and having this sort of stuff in the kernel means it might get
picked up as reference code by other users.  If you want to label the
supplies to match the rails on the board the name field in constraints
is intended for that purpose.
