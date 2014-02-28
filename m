From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 28 Feb 2014 17:20:08 +0800
Subject: change kmalloc into vmalloc for large memory allocations
In-Reply-To: <53104ECA.4010702@freescale.com>
References: <35FD53F367049845BC99AC72306C23D102844605F38C@CNBJMBX05.corpusers.net>
 <53104ECA.4010702@freescale.com>
Message-ID: <35FD53F367049845BC99AC72306C23D102844605F38D@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi  


Yeah,  
Dma buffer must be allocated by kmalloc,

But the modules I list should can all be changed to use
vmalloc, because the buffer is only used by software,
Not by any hardware .


Thanks

-----Original Message-----
From: Huang Shijie [mailto:b32955 at freescale.com] 
Sent: Friday, February 28, 2014 4:55 PM
To: Wang, Yalin
Cc: 'linux-kernel at vger.kernel.org'; 'linux-arm-msm at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org'; 'linux-input at vger.kernel.org'; 'balbi at ti.com'; 'gregkh at linuxfoundation.org'; 'lrg at ti.com'; 'broonie at opensource.wolfsonmicro.com'; 'perex at perex.cz'; 'tiwai at suse.de'; 'pablo at netfilter.org'; 'kaber at trash.net'; 'davem at davemloft.net'; 'rostedt at goodmis.org'; 'fweisbec at gmail.com'; 'mingo at redhat.com'; 'dmitry.torokhov at gmail.com'; 'rydberg at euromail.se'; 'linux-usb at vger.kernel.org'; 'alsa-devel at alsa-project.org'; 'netfilter-devel at vger.kernel.org'; 'netfilter at vger.kernel.org'; 'coreteam at netfilter.org'; 'netdev at vger.kernel.org'
Subject: Re: change kmalloc into vmalloc for large memory allocations

? 2014?02?28? 16:15, Wang, Yalin ??:
> could this module change the memory allocation into vmalloc ?
the buffer allocated by vmalloc can not be used for the DMA.

I think that's why drivers use the kmalloc.

thanks
Huang Shijie
