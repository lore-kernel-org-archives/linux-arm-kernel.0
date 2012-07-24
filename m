From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 Jul 2012 23:46:50 +0100
Subject: Help request - ASoC recursion issue
In-Reply-To: <500E4E2C.3060804@linaro.org>
References: <500D5A1F.9000808@linaro.org> <500D649B.80704@linaro.org>
 <500D6602.6070809@linaro.org>
 <20120723181249.GF3421@mudshark.cambridge.arm.com>
 <500E4E2C.3060804@linaro.org>
Message-ID: <20120724224649.GE1767@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2012 at 08:26:36AM +0100, Lee Jones wrote:

> Yes, I am inclined to agree with you. I just thought it was  
> uncharacteristic of a memory corruption error, as can reliably reproduce  
> the bootlog above. What's even more strange is that the issue only  
> arises on one of my two _identical_ development boards.

It's not that unusual depending on where the cause is - for example,
copying an initialised struct to the wrong place, and things like the
DAPM graph which are big and pointer driven are often affected.
