From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 06 Sep 2010 19:21:50 +0900
Subject: [PATCH 3/4] ARM: S5PC110: add common FIMC setup code
In-Reply-To: <AANLkTikakB1Y6N-UT2Hx+PHfdyticHxCFQzs=uc7KWNc@mail.gmail.com>
References: <1283745044-15514-1-git-send-email-m.szyprowski@samsung.com>
	<1283745044-15514-4-git-send-email-m.szyprowski@samsung.com>
	<AANLkTinhbmKX5gs4TPZwVUX0WSEQ5RLN+_gHAqXsTj1b@mail.gmail.com>
	<4C84AA6D.10509@samsung.com>
	<AANLkTikakB1Y6N-UT2Hx+PHfdyticHxCFQzs=uc7KWNc@mail.gmail.com>
Message-ID: <4C84C0BE.3050305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2010-09-06 18:17, Jassi Brar wrote:

>> I'm thinking of making the parent clock an argument to the
>> s5pv210_fimc_setup_clks().
> Yes, that's better since the relevant clock is managed by the CMU

What do you mean by the CMU? This function is intended to be called from 
board startup code.

>> I really don't like the idea of passing clock name through the platform data
>> and letting driver to mess with clock's parents.
> In case of SPI the clock mux and scalar is present _within_ the SPI
> controller and having to touch SPI regs from outside the driver isn't
> what I prefer.

I know. It is the same case as with SDHCI and UART controllers. I have 
an idea how to solve this in a bit more cleaner way. I hope to post a 
proposition soon.

>> Machine startup code is the
>> last place where such things should be changed.
> Until I am enlightened, I'd like to think otherwise.
> I think the board designer would already have thought out the clock sourcing
> hierarchy. Setting appropriate parents once at boot-time and having drivers
> not worry about it, should be better.

Definitely, but in our case kernel the default fimc_sclk parent points 
to non-existing clock.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
