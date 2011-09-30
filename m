From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 30 Sep 2011 11:28:49 +0100
Subject: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <4E854532.6080605@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
	<4E81E224.2070408@ti.com>
	<20110927150511.GM4289@opensource.wolfsonmicro.com>
	<4E854532.6080605@ti.com>
Message-ID: <20110930102849.GA4195@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 09:57:30AM +0530, Rajendra Nayak wrote:

> Mark, I still seem to be a little confused with this one as to why
> we would need a phandle *and* a supply-name to reference a parent
> regulator/supply.
> The phandle would point to a regulator dt node and that node internally
> would have just one name associated with it.

To repeat: the supply name is for the consumer.  It is needed so that
the consumer can tell which supply is provided by which regulator.
Almost all devices have more than one supply and if the device does
anything more complicated than just turning on all the supplies when the
device is active it's going to need to figure out which supply is which.

Also, please do remember to keep linux-kernel in the loop on all
regulator API discussion - you should always keep the relevant mailing
lists in the loop for any subsystem you're changing.
