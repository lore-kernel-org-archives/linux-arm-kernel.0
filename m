From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 21 Oct 2013 00:42:48 +0200
Subject: [PATCH] ARM: s3c64xx: mini6410: Correct card detect type for
 HSMMC1
In-Reply-To: <5264529C.1000601@samsung.com>
References: <1380471121-9478-1-git-send-email-tomasz.figa@gmail.com>
 <1e2a01cecb91$f790c700$e6b25500$@org> <5264529C.1000601@samsung.com>
Message-ID: <1538561.RlaZEsIrlT@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Monday 21 of October 2013 07:01:00 Kukjin Kim wrote:
> On 10/18/13 08:38, Kukjin Kim wrote:
> > Tomasz Figa wrote:
> >> Hi Kukjin,
> > 
> > Hi,
> > 
> >> On Sunday 29 of September 2013 18:12:01 Tomasz Figa wrote:
> >>> According to board schematics, for HSMMC1 a GPIO line is used to
> >>> detect
> >>> card presence, while currently it is being configured for internal
> >>> card
> >>> detect line, which is multiplexed with card detect line of HSMMC0 and
> >>> thus breaking it.
> >>> 
> >>> This patch adds proper sdhci platform data setting card detect type
> >>> to
> >>> external GPIO and fixing operation of HSMMC0.
> >>> 
> >>> Signed-off-by: Tomasz Figa<tomasz.figa@gmail.com>
> >>> ---
> >>> 
> >>>   arch/arm/mach-s3c64xx/mach-mini6410.c | 10 ++++++++++
> >>>   1 file changed, 10 insertions(+)
> >> 
> >> Would you mind taking this patch to your tree?
> > 
> > Applied, thanks.
> > Kukjin
> 
> Uhm...just small concern...it's possible to support dt for mini6410 but
> basic. I need to hold this on...

May I ask you to explain your concern about this?

I believe this bug fix is fine, since we still support board files for 
s3c64xx and DT based support is experimental at the moment.

Best regards,
Tomasz
