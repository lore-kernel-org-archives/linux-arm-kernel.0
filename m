From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 09:48:21 -0700
Subject: [PATCH 1/2] irqchip: sirf: move from legacy mode to linear
 irqdomain
In-Reply-To: <1375767434-19842-1-git-send-email-Baohua.Song@csr.com>
References: <1375767434-19842-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130829164821.GA18542@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 01:37:13PM +0800, Barry Song wrote:
> the series of patches for irqdomain core in 3.11 has broken sirf
> irq which uses legacy mapping. all users fail in the new kernel
> while setupping irq.
> 
> this patch moves to linear irqdomain and drop old legacy irqdomain
> codes since we don't need it any more, and at the same time, it
> also fixes the broken interrupts of sirfsoc in 3.11.
> 
> on the other hand, we actually only have 64 interrupt sources for
> prima2 and atlas6, but there are 128 interrupt souces for marco
> which uses GIC. in the legacy codes, sirf gpio also uses legacy
> irqdomain, so to make gpio interrupt mapping not depend on the
> prima2/atlas6/marco an use unified marco,we enlarge prima2/atlas6
> interrupt number to 128. here we don't need this workaround any
> more as sirf gpio also moved to linear mode before. so we move
> SIRFSOC_NUM_IRQS back to 64 too.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Sorry for missing this earlier. I'll apply and send up for 3.11.


-Olof
