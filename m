From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Nov 2010 11:36:55 +0000
Subject: [PATCH 1/3] mfd: Added new regulator_data pointer to ab8500
	board configuration
In-Reply-To: <4CECCBAE.6080707@stericsson.com>
References: <1290536754-21775-1-git-send-email-bengt.g.jonsson@stericsson.com>
	<1290536754-21775-2-git-send-email-bengt.g.jonsson@stericsson.com>
	<20101123183037.GA19212@rakim.wolfsonmicro.main>
	<4CECCBAE.6080707@stericsson.com>
Message-ID: <20101124113655.GC24970@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 09:24:14AM +0100, Bengt Jonsson wrote:

> The problem I see is that ab8500-core defines the number of
> regulators which I can see no reason for. If someone wants to add or
> remove a regulator they have to make a change in
> include/linux/mfd/ab8500.c as well as in the regulator files.

> I will add a better description in an updated patch.

Seems reasonable, though there's now an issue with the platform getting
the size of the array wrong - might be worth adding an array size for
the platform to initialise to catch that.
