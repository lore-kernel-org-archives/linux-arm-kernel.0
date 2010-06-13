From: mike@compulab.co.il (Mike Rapoport)
Date: Sun, 13 Jun 2010 09:57:38 +0300
Subject: [PATCH 4/5] [ARM] usb/host/ohci-pxa27x: make PXA310 USB OTG port
	work in host mode.
In-Reply-To: <AANLkTilUt8D7B3UF_j1wOvsnXTVQyioofwMEikScdLOn@mail.gmail.com>
References: <1275464450-23003-1-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-2-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-3-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-4-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-5-git-send-email-grinberg@compulab.co.il>
	<AANLkTilUt8D7B3UF_j1wOvsnXTVQyioofwMEikScdLOn@mail.gmail.com>
Message-ID: <4C148162.2020507@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:
> On Wed, Jun 2, 2010 at 3:40 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
>>  arch/arm/mach-pxa/include/mach/ohci.h     |    3 +
>>  arch/arm/mach-pxa/include/mach/regs-u2d.h |    2 +
>>  drivers/usb/host/ohci-pxa27x.c            |  183 +++++++++++++++++++++++++++++
> 
> My feeling is on pxa310, the OTG/ULPI is actually closer to the UDC, so
> generally, I'd really like to see minimum change to ohci.

There are certain registers set up that should be done in order to 
enable the pxa310 otg port in the host mode. I agree that most of them 
should be done in the UDC driver, but since there's no UDC driver at all 
for pxa310, the most logical place for those register set ups would be 
pxa ohci glue driver.

-- 
Sincerely yours,
Mike.
