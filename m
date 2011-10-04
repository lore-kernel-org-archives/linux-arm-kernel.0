From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 4 Oct 2011 11:18:47 +0100
Subject: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <4E8A9988.3080907@ti.com>
References: <1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
	<4E81E224.2070408@ti.com>
	<20110927150511.GM4289@opensource.wolfsonmicro.com>
	<4E854532.6080605@ti.com>
	<20110930102849.GA4195@opensource.wolfsonmicro.com>
	<20110930104820.GE2085@sirena.org.uk> <4E85A34E.9070203@ti.com>
	<20110930121844.GI5366@opensource.wolfsonmicro.com>
	<4E8A9988.3080907@ti.com>
Message-ID: <20111004101846.GD3250@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2011 at 10:58:40AM +0530, Rajendra Nayak wrote:

> The problem is I don't know if the property in the regulator dt
> node is called "vin-supply" or "vxyz-supply" and hence I
> can parse the property based on a substring alone, which is
> "-supply" because all I know is the property name is expected
> to end with a "-supply".

This seems fairly straightforward though it will require some changes
within Linux, all we have to do is have the regulators name their
supplies.
