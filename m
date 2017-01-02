From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Jan 2017 18:10:44 +0100
Subject: [PATCH 0/3] crypto: picoxcell - Cleanups removing non-DT code
In-Reply-To: <1483376819-26726-1-git-send-email-javier@osg.samsung.com>
References: <1483376819-26726-1-git-send-email-javier@osg.samsung.com>
Message-ID: <2309314.lMWYhcWsTB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 2, 2017 2:06:56 PM CET Javier Martinez Canillas wrote:
> 
> This small series contains a couple of cleanups that removes some driver's code
> that isn't needed due the driver being for a DT-only platform.
> 
> The changes were suggested by Arnd Bergmann as a response to a previous patch:
> https://lkml.org/lkml/2017/1/2/342
> 
> Patch #1 allows the driver to be built when the COMPILE_TEST option is enabled.
> Patch #2 removes the platform ID table since isn't needed for DT-only drivers.
> Patch #3 removes a wrapper function that's also not needed if driver is DT-only.
> 
> 

Looks good, but I don't know if the first patch causes some build warnings
on non-ARM platforms, better wait at least for the 0-day build results,
and maybe build-test on x86-32 and x86-64.

	Arnd
