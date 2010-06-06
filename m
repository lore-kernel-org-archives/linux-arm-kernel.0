From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 06 Jun 2010 09:15:10 +0300
Subject: [PATCH 0/5] Enable pxa310 usb otg port host mode.
In-Reply-To: <AANLkTil7KUMIqP76bXAOOCiAfISzCiixtMzNDAHo7kNo@mail.gmail.com>
References: <1275464450-23003-1-git-send-email-grinberg@compulab.co.il>
	<AANLkTil7KUMIqP76bXAOOCiAfISzCiixtMzNDAHo7kNo@mail.gmail.com>
Message-ID: <4C0B3CEE.80000@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping!

On 06/02/10 11:29, Eric Miao wrote:
> On Wed, Jun 2, 2010 at 3:40 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>   
>> This patch series extends the existing usb ulpi generic driver
>> with support for Function and Interface control of the ULPI PHYs,
>> adds support for SMSC USB3319 ulpi phy,
>> implement the pxa310 specific ulpi functionality and make pxa specific ohci
>> implementation aware of pxa310 usb otg port host mode.
>>
>>     
> Looks like a right way to go, include Haojian and Jing for review.
>
>   
>> Igor Grinberg (5):
>>  usb/otg/ulpi: extend the generic ulpi driver.
>>  usb/otg/ulpi: add support for SMSC USB3319 ulpi phy.
>>  [ARM] pxa: add PXA310 specific ULPI implementation
>>  [ARM] usb/host/ohci-pxa27x: make PXA310 USB OTG port work in host
>>    mode.
>>  [ARM] pxa/cm-x300: enable USB host port 2 on CM-X300 with PXA310 cpu.
>>
>>  arch/arm/mach-mx2/mach-pca100.c              |   10 +-
>>  arch/arm/mach-mx3/mach-armadillo5x0.c        |   10 +-
>>  arch/arm/mach-mx3/mach-mx31lite.c            |    5 +-
>>  arch/arm/mach-mx3/mach-mx31moboard.c         |    5 +-
>>  arch/arm/mach-mx3/mach-pcm037.c              |   10 +-
>>  arch/arm/mach-mx3/mach-pcm043.c              |    5 +-
>>  arch/arm/mach-pxa/Kconfig                    |    4 +
>>  arch/arm/mach-pxa/Makefile                   |    1 +
>>  arch/arm/mach-pxa/cm-x300.c                  |  102 ++++++++++++++
>>  arch/arm/mach-pxa/include/mach/ohci.h        |    3 +
>>  arch/arm/mach-pxa/include/mach/pxa310-ulpi.h |   19 +++
>>  arch/arm/mach-pxa/include/mach/regs-u2d.h    |    2 +
>>  arch/arm/mach-pxa/pxa310-ulpi.c              |  110 +++++++++++++++
>>  drivers/usb/host/ohci-pxa27x.c               |  183 ++++++++++++++++++++++++++
>>  drivers/usb/otg/Kconfig                      |    2 -
>>  drivers/usb/otg/ulpi.c                       |   65 ++++++++-
>>  include/linux/usb/ulpi.h                     |   25 ++++-
>>  17 files changed, 542 insertions(+), 19 deletions(-)
>>  create mode 100644 arch/arm/mach-pxa/include/mach/pxa310-ulpi.h
>>  create mode 100644 arch/arm/mach-pxa/pxa310-ulpi.c
>>
>>
>>     
>   

-- 
Regards,
Igor.
