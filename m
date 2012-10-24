From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Oct 2012 15:53:08 +0100
Subject: [PATCH 1/1] mmc: Standardise capability type
In-Reply-To: <201210241321.26878.arnd@arndb.de>
References: <1351084664-30526-1-git-send-email-lee.jones@linaro.org>
 <201210241321.26878.arnd@arndb.de>
Message-ID: <20121024145308.GE3537@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Oct 2012, Arnd Bergmann wrote:

> On Wednesday 24 October 2012, Lee Jones wrote:
> > 
> > There are discrepancies with regards to how MMC capabilities
> > are carried throughout the subsystem. Let's standardise them
> > to elevate any confusion.
> > 
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: linux-mmc at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Why make it "unsigned long" then? I think that adds to the
> confusion because it's sometimes 32 bits and sometimes 64 bits,
> depending on the CPU. Since it's a bitmask, I would suggest
> using u32 to make the size explicit.

I'm not sure that it leaves any confusion. It perhaps wastes a little
space on 64bit architectures, but that also applies to a great deal
of other bitmasks floating around.

I can do it if you feel that passionate about it, but it's a bigger
job to hunt down all occurrences and change them over. I only felt
strongly enough about it to craft this patch because I noticed the
inconsistency as I created new populate caps for OF functionality.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
