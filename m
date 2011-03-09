From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 Mar 2011 13:15:11 +0000
Subject: [PATCH 2/3] ARM: tegra: harmony: initialize the TPS65862 PMIC
In-Reply-To: <4D777E6C.5040000@compulab.co.il>
References: <cover.1299588456.git.mike@compulab.co.il>
	<4ade6d195fff78271085eafb0a99de3be8beb426.1299588456.git.mike@compulab.co.il>
	<20110308131541.GB5892@sirena.org.uk>
	<4D772F23.70304@compulab.co.il>
	<20110309101508.GD6923@opensource.wolfsonmicro.com>
	<4D776A42.9030107@compulab.co.il>
	<20110309122222.GG6923@opensource.wolfsonmicro.com>
	<4D777E6C.5040000@compulab.co.il>
Message-ID: <20110309131511.GB30257@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2011 at 03:19:40PM +0200, Mike Rapoport wrote:
> On 03/09/11 14:22, Mark Brown wrote:

> > Note that there's no issue with having no supplies set for a regulator
> > so no reason not to register the supplies themselves, it's just the
> > supply map that I was flagging.

> I.e. having something like

> static struct regulator_consumer_supply tps658621_ldo7_supply[] = {
> };

Well, I'd just omit the array entirely if it's empty but yes.
