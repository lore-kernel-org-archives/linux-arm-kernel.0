From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 25 Feb 2016 23:41:50 -0800
Subject: next-20160225 build: 2 failures 44 warnings (next-20160225)
In-Reply-To: <20160226030949.GL18327@sirena.org.uk>
References: <E1aYsmb-0006qb-76@optimist> <20160226030949.GL18327@sirena.org.uk>
Message-ID: <56D001BE.2090209@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 02/25/2016 07:09 PM, Mark Brown wrote:
> On Thu, Feb 25, 2016 at 10:04:29AM +0000, Build bot for Mark Brown wrote:
>
> Today's -next fails to build an arm64 allmodconfig due to:
>
>> 	arm64-allmodconfig
>> ../drivers/watchdog/orion_wdt.c:109:2: error: implicit declaration of function 'atomic_io_modify' [-Werror=implicit-function-declaration]
>
> also caused by b4f596b19624 (arm64: add mvebu architecture entry) which
> enables MVBEU on arm64, the commit was present for a little while and
> the error cropped up but didn't get reported due to other things masking
> it.  atomic_io_modify() is only available on ARM, I'm unsure if this
> needs a driver change or if the driver is just specific to older
> hardware anyway.  The code is only used in the init path accessing what
> look to be device specific registers so I'm not 100% clear why it
> specifically needs to be an atomic modify.
>
Thierry already submitted a patch yesterday to restrict the driver to only
build on ARM. We can revisit if/when the driver is needed on ARM64.

Guenter
