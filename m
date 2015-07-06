From: dvhart@infradead.org (Darren Hart)
Date: Mon, 6 Jul 2015 11:18:14 -0700
Subject: [PATCH] thermal: consistently use int for temperatures
In-Reply-To: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150706181814.GB40907@vmdeb7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 09:19:49AM +0200, Sascha Hauer wrote:
> The thermal code uses int, long and unsigned long for temperatures
> in different places.
> 
> Using an unsigned type limits the thermal framework to positive
> temperatures without need. Also several drivers currently will report
> temperatures near UINT_MAX for temperatures below 0?C. This will probably
> immediately shut the machine down due to overtemperature if started below
> 0?C.
> 
> 'long' is 64bit on several architectures. This is not needed since INT_MAX ?mC
> is above the melting point of all known materials.
> 
> Consistently use a plain 'int' for temperatures throughout the thermal code and
> the drivers. This only changes the places in the drivers where the temperature
> is passed around as pointer, when drivers internally use another type this is
> not changed.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

...

>  drivers/platform/x86/acerhdf.c                     |  9 ++++----
>  drivers/platform/x86/intel_mid_thermal.c           |  9 ++++----

For these two:

Reviewed-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center
