From: stigge@antcom.de (Roland Stigge)
Date: Sat, 25 Feb 2012 15:03:46 +0100
Subject: [PATCH v2] USB: Support for LPC32xx SoC
In-Reply-To: <20120225035128.GA4455@pengutronix.de>
References: <1330030639-3796-1-git-send-email-stigge@antcom.de>
 <4F46AA06.30502@antcom.de> <20120224063521.GA16412@pengutronix.de>
 <201202241503.27406.arnd@arndb.de> <20120225035128.GA4455@pengutronix.de>
Message-ID: <4F48EA42.70408@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/02/12 04:51, Wolfram Sang wrote:
>> Unfortunately, the way that ohci handles the abstraction between
>> the various implementations is backwards, it would be much easier
>> if the main driver was following that model to start with.
> 
> ... exactly for that reason I didn't suggest it. Looking at other
> ohci-sources (e.g. ohci-omap.c), machine_is_* seems to be the
> consistent use-case.

OK, considering this, I for now used machine_is_*() to get rid of the
#ifdefs.

Using platform_device_id.driver_data as Arnd suggested is also a good
idea, and switching to it will be easy when it is due.

Thanks in advance,

Roland
