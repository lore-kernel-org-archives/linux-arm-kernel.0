From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 30 Apr 2014 13:21:01 -0300
Subject: [PATCH for v3.15] net: mvmdio: Check for a valid interrupt
 instead of an error
In-Reply-To: <5360FA35.7070209@gmail.com>
References: <1398800999-9814-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <53601B96.3000608@gmail.com> <20140430114209.GA1907@arch.cereza>
 <5360FA35.7070209@gmail.com>
Message-ID: <20140430162101.GA18300@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 30, Sebastian Hesselbarth wrote:
> >
> >Yes, I agree. Did another patch for that, but haven't send it yet.
> >AFAICS, mvebu platforms will never hit the deferred case as the irqchip
> >is the first driver registered (as per drivers/Makefile).
> >
> >Not that we should count on that :)
> 
> It doesn't hit it _now_ because of the above. I read about proper
> platform_device for early devices here and there over and over
> again, so I guess some day it may become an issue.
> 
> As we know about the potential -EPROBE_DEFER now, I suggest to
> deal with it now, too.
> 
> Can you resend this as v2 with the other patch you mentioned
> squashed in?
> 

Oh! I've just remembered why I didn't send the EPROBE_DEFER patch in the first
place. The mvneta driver connects to the phy at open()-time, in a function
called "mvneta_mdio_probe()". This name confused me to think the mdio was
really probed at open()-time.

I guess it was very late at night when I came to such conclusion :)
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
