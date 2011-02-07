From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 Feb 2011 11:58:20 +0000
Subject: [PATCH 07/09] ARM: s3c2440: gta02: Call
	regulator_has_full_constraints
In-Reply-To: <1297043521-21903-7-git-send-email-lars@metafoo.de>
References: <1297043521-21903-1-git-send-email-lars@metafoo.de>
	<1297043521-21903-7-git-send-email-lars@metafoo.de>
Message-ID: <20110207115820.GB1196@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 07, 2011 at 02:51:59AM +0100, Lars-Peter Clausen wrote:
> At the end of gta02_pmu_attach_child_devices all drivers should have taken
> control of their regulators and we can tell the regulator core to disable all
> regulators which are currently not in use.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

You're misunderstanding this API.  It can be called at any time and will
only actually do anything at the end of init.  You should just call it
from your machine init.
