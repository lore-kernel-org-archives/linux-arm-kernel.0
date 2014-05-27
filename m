From: marc.ceeeee@gmail.com (Marc Carino)
Date: Tue, 27 May 2014 10:15:25 -0700
Subject: [PATCH] ARM: zImage: add DSB and ISB barriers after relocating
 code
In-Reply-To: <alpine.LFD.2.11.1405222305310.17310@knanqh.ubzr>
References: <1400808472-401-1-git-send-email-marc.ceeeee@gmail.com>
 <alpine.LFD.2.11.1405222155240.17310@knanqh.ubzr>
 <537EB8F2.3090401@gmail.com>
 <alpine.LFD.2.11.1405222305310.17310@knanqh.ubzr>
Message-ID: <5384C82D.1050506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nicolas,

> I assume that invalidating the i-cache would be a good thing to do in
> all cases.

Great! It looks like I'll be able to augment the existing cache function
lookup table with an additional I-cache invalidate operation.

> I'm curious though: at what address do you load your zImage, and what
> address does RAM start?

On our platform, we load the kernel zImage at address PA:0x8000. The
start of physical memory is at PA:0x0.

Thank you,
Marc
