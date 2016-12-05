From: romain.perier@free-electrons.com (Romain Perier)
Date: Mon, 5 Dec 2016 10:19:20 +0100
Subject: [crypto] [marvell-cesa] Possible regression after Linux 4.7
In-Reply-To: <4573998d-6c5b-03e4-e1fa-7516d5a9e276@free-electrons.com>
References: <58174e5d.233ac20a.a4335.5656@mx.google.com>
 <4573998d-6c5b-03e4-e1fa-7516d5a9e276@free-electrons.com>
Message-ID: <2b1fd86d-956c-398f-b644-cc9b1fd3d78c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The issue is reproducible in STD mode too. We have found fixes.
Could you test these patches in STD mode please ?


cover letter: 
https://www.mail-archive.com/linux-crypto at vger.kernel.org/msg22143.html
1/2: https://www.mail-archive.com/linux-crypto at vger.kernel.org/msg22142.html
2/2: https://www.mail-archive.com/linux-crypto at vger.kernel.org/msg22141.html

If you want to turn off DMA, open drivers/crypto/marvell/cesa.c and in 
armada_xp_caps, change .has_tdma to false.  (assuming that you test on a 
armada 38x).

We're still investigating for regressions in DMA mode.

Have a nice day,
Romain

-- 
Romain Perier, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
