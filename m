From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Dec 2012 15:10:03 +0000
Subject: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into
 the driver
In-Reply-To: <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
 <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121214151002.GK14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 03:30:29PM +0100, Ulf Hansson wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> There are currently two instances of the ios_handler being used.
> Both of which mearly toy with some regulator settings. Now there
> is a GPIO regulator API, we can use that instead, and lessen the
> per platform burden. By doing this, we also become more Device
> Tree compatible.

Err, why is this needed?  What's wrong with using the 'vmmc' for this?

>From what I read in the mmc core, vmmc handling via mmc_regulator_set_ocr()
can cope with GPIO-based regulators, and if you have a single GPIO signal
then you have a single supply (it's either on or off).  So what's wrong
with using the existing regulator hooks for this which are already there?
