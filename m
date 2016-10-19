From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 19 Oct 2016 16:30:55 +0200
Subject: [PATCH v2 0/2] ARM: at91: properly handle LPDDR poweroff
In-Reply-To: <CAMuHMdUnoHPOQeO=oSRkNWbfLGDzZbBZvPFr3dS7TOKPQFcUxQ@mail.gmail.com>
References: <20161019114420.15213-1-alexandre.belloni@free-electrons.com>
 <CAMuHMdUnoHPOQeO=oSRkNWbfLGDzZbBZvPFr3dS7TOKPQFcUxQ@mail.gmail.com>
Message-ID: <585ae249-07ef-5299-17aa-2bcf79a09f24@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/10/2016 ? 16:07, Geert Uytterhoeven a ?crit :
> On Wed, Oct 19, 2016 at 1:44 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>> LPDDR memories can only handle up to 400 uncontrolled power offs in their
>> life. The proper power off sequence has to be applied before shutting down the
>> SoC.
> 
> Interesting. How many boards have been killed during kernelci.org
> operation?

The reason given above is usually the one that prevent manufacturers
from using LPDDR on "evaluation" boards. So all Atmel boards use
SDRAM/DDR2/DDR3 not the LP variants.

Final products (and internal validation boards, obviously) though use
these type of RAM so we must be prepared to handle them.

Best regards,
-- 
Nicolas Ferre
