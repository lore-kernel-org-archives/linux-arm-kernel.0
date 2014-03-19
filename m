From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 19 Mar 2014 13:27:59 -0300
Subject: i.MX53 suspend to RAM
In-Reply-To: <5329A13A.7080307@parkeon.com>
References: <5322D844.50203@parkeon.com>
 <CAOMZO5Bg2zaGwptGwiVgagaCQCLDgMQfN=5_RwS0tLV0ketxPg@mail.gmail.com>
 <5329A13A.7080307@parkeon.com>
Message-ID: <CAOMZO5Dt4zxk9O0WWUjLv_FSW4VmCJBK-ok-hACfr-uS3Sa_Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 10:52 AM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:

> After doing some more digging it seems the problem is actually the staging
> IPU driver imx-drm.
>
> That driver currently has no suspend code and does not stop DMA.
>
> If I remove the driver I can reliably suspend and resume (>500 cycles ok)

Ok, great.

>
> So sorry for the noise.
>
>
> Are there any suspend/resume patches for that driver floating around?

Not that I am aware of.

> I have tried to do something similar to the Freescale driver (wait for DMA
> channels to idle then disable them)
> but, while this also fixes the suspend/resume hang, there is sometimes no or
> shifted display on resume.

I would suggest you to post your IPU suspend/resume patch as RFC so
that we could try to figure out this issue.

Regards,

Fabio Estevam
