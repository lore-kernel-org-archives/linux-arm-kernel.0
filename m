From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 4 Nov 2013 09:01:11 -0300
Subject: [PATCH v2 07/27] mtd: nand: pxa3xx: Early variant detection
In-Reply-To: <20131103211856.GA5896@gmail.com>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382137374-21251-8-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131103211856.GA5896@gmail.com>
Message-ID: <20131104120110.GC2516@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 03, 2013 at 04:18:58PM -0500, Huang Shijie wrote:
> On Fri, Oct 18, 2013 at 08:02:34PM -0300, Ezequiel Garcia wrote:
> > In order to customize early settings depending on the detected SoC variant,
> what's the early settings depending on the variant?

We need to detect the variant *before* alloc_nand_resource(),
in order to set a different cmdfunc() for each variant.

Having a separate cmdfunc() is, IMO, the best solution for two
reasons:

1. We keep the legacy pxa platform away from our intrusive changes,
which such platform won't use.

2. The 'splitted' command semantic is weird and complex enough
to live in its own function.

> could you add them in the commit?
> 

Yes, that sound better. Thanks for the feedback.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
