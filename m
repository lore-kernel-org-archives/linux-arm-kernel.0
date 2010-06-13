From: mike@compulab.co.il (Mike Rapoport)
Date: Sun, 13 Jun 2010 10:06:50 +0300
Subject: [PATCH 4/5] [ARM] usb/host/ohci-pxa27x: make PXA310 USB OTG port
	work in host mode.
In-Reply-To: <AANLkTin2RmVoFhF7-2iWIx_7hRr473KZnyq9FOqZhcWi@mail.gmail.com>
References: <1275464450-23003-1-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-2-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-3-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-4-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-5-git-send-email-grinberg@compulab.co.il>
	<AANLkTilUt8D7B3UF_j1wOvsnXTVQyioofwMEikScdLOn@mail.gmail.com>
	<4C148162.2020507@compulab.co.il>
	<AANLkTin2RmVoFhF7-2iWIx_7hRr473KZnyq9FOqZhcWi@mail.gmail.com>
Message-ID: <4C14838A.7060509@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:
> On Sun, Jun 13, 2010 at 2:57 PM, Mike Rapoport <mike@compulab.co.il> wrote:
>> Eric Miao wrote:
>>> On Wed, Jun 2, 2010 at 3:40 PM, Igor Grinberg <grinberg@compulab.co.il>
>>> wrote:
>>>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>>>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>>>> ---
>>>>  arch/arm/mach-pxa/include/mach/ohci.h     |    3 +
>>>>  arch/arm/mach-pxa/include/mach/regs-u2d.h |    2 +
>>>>  drivers/usb/host/ohci-pxa27x.c            |  183
>>>> +++++++++++++++++++++++++++++
>>> My feeling is on pxa310, the OTG/ULPI is actually closer to the UDC, so
>>> generally, I'd really like to see minimum change to ohci.
>> There are certain registers set up that should be done in order to enable
>> the pxa310 otg port in the host mode. I agree that most of them should be
>> done in the UDC driver, but since there's no UDC driver at all for pxa310,
> 
> Wow, that's a big problem.
 >
>> the most logical place for those register set ups would be pxa ohci glue
>> driver.
>>
> 
> So, is there a simple way to setup the ULPI for the host within mach-pxa/*?
> We need really really simple code for that, so it has minimum impact when
> we move that part into pxa310-udc.c? I still want ohci-pxa27x to remain
> minimum impacted.

we can put most of the code in, say, arch/arm/mach-pxa/pxa3xx-u2d.c and 
add hooks in ohci-pxa27x.

-- 
Sincerely yours,
Mike.
