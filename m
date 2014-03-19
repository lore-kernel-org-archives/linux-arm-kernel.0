From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 19 Mar 2014 14:52:58 +0100
Subject: i.MX53 suspend to RAM
In-Reply-To: <CAOMZO5Bg2zaGwptGwiVgagaCQCLDgMQfN=5_RwS0tLV0ketxPg@mail.gmail.com>
References: <5322D844.50203@parkeon.com>
 <CAOMZO5Bg2zaGwptGwiVgagaCQCLDgMQfN=5_RwS0tLV0ketxPg@mail.gmail.com>
Message-ID: <5329A13A.7080307@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 16/03/14 15:39, Fabio Estevam wrote:
> I will try to stress test suspend/resume on mx53qsb and will let you know.

After doing some more digging it seems the problem is actually the 
staging IPU driver imx-drm.

That driver currently has no suspend code and does not stop DMA.

If I remove the driver I can reliably suspend and resume (>500 cycles ok)

So sorry for the noise.


Are there any suspend/resume patches for that driver floating around?

I have tried to do something similar to the Freescale driver (wait for 
DMA channels to idle then disable them)
but, while this also fixes the suspend/resume hang, there is sometimes 
no or shifted display on resume.


Regards,

Martin
