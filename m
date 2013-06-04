From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 04 Jun 2013 16:12:24 +0200
Subject: [PATCH v3] ARM: at91: Fix link breakage when !CONFIG_PHYLIB
In-Reply-To: <51ADF04D.3040703@atmel.com>
References: <1369651702-9207-1-git-send-email-alexandre.belloni@free-electrons.com>
 <51A34BF9.5000905@atmel.com> <6343931.uK9ItNlUFg@wuerfel>
 <51ADF04D.3040703@atmel.com>
Message-ID: <51ADF5C8.80007@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2013 15:49, Nicolas Ferre wrote:
>
> ... simply use this "IS_BUILTIN(CONFIG_PHYLIB)" here -----^^^^^^^^^
> (and not above as suggested by Arnd).
>
> Jean-Christophe, Alexandre: do you agree with this conclusion?
>
> I plan to stack this patch for next at91-fixes batch.
>

Yeah, I prepared and tested that last week but didn't send it yet. I can
do it now if you want but you could probably just edit my patch. I'd
like to fix the other platforms too but that probably can wait.

I believe we would still have to fix the phy_register_fixup*() works as
it is always called from arch/ and is clearly not fool proofed enough.
Maybe DT could help ?

Arnd, do you have any input ?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
