From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 27 Nov 2012 14:34:07 +0000
Subject: [PATCH 1/3] Input: bu21013_ts - Request a regulator that
 actually exists
In-Reply-To: <20121127133404.GA13065@sirena.org.uk>
References: <1354021990-16978-1-git-send-email-lee.jones@linaro.org>
 <1354021990-16978-2-git-send-email-lee.jones@linaro.org>
 <20121127133404.GA13065@sirena.org.uk>
Message-ID: <20121127143407.GG2013@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Nov 2012, Mark Brown wrote:

> On Tue, Nov 27, 2012 at 01:13:08PM +0000, Lee Jones wrote:
> > Currently the BU21013 Touch Screen driver requests a regulator by the
> > name of 'V-TOUCH', which doesn't exist anywhere in the kernel. The
> > correct name, as referenced in platform regulator code is 'avdd'. Here,
> > when we request a regulator, we use the correct name instead.
> 
> The regulator should be requested using whatever the name for the supply
> in the datasheet - AVDD does sound very pluasible but it'd be good to
> check.

Right. 'avdd' is correct.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
