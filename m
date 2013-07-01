From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 01 Jul 2013 21:28:26 +0200
Subject: [alsa-devel] [PATCH 1/4] ASoC: sgtl5000: give it a ramping time
 before writting
In-Reply-To: <CAOMZO5DtgahX3WLdM-P9=ODhJVMTRHFuS9=6zHQiS9-3wCJcmA@mail.gmail.com>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <20130701153327.GX13206@S2101-09.ap.freescale.net>
 <CAOMZO5B5jh1XciO4K1u3yBcHHDAgi8hA3GcywnJd11M7=aOPxA@mail.gmail.com>
 <201307011943.27489.marex@denx.de>
 <CAOMZO5DtgahX3WLdM-P9=ODhJVMTRHFuS9=6zHQiS9-3wCJcmA@mail.gmail.com>
Message-ID: <51D1D85A.8060807@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/07/2013 21:14, Fabio Estevam wrote:
> Hi Marek,
> 
> On Mon, Jul 1, 2013 at 2:43 PM, Marek Vasut <marex@denx.de> wrote:
> 
>> I think you can just disable the PIO mode altogether (around line 500 ... if
>> (msg->len < 8) ... replace this with if (0) ) and then the problem should not be
>> there (if it's a PIO problem).
> 
> Yes, this is a good suggestion.
> 
> This is what I did on 3.10 kernel:
> 
> - Booted a 3.10 kernel, audio is probed correctly
> 
> - Enabled touchscreen:
> 

It definitely seems to be an issue with PIO mode as the investigation
from Torsten Fleischer showed. I'll test that on my boards tonight. I'll
also try to remove the touchscreen support to see if I observe the same
thing as you do.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
