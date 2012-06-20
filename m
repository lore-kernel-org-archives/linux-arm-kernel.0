From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Jun 2012 13:40:17 +0800
Subject: [RFC PATCH 1/1] ARM: imx: enable SPARSE_IRQ for imx
In-Reply-To: <20120620022313.GE10387@shlinux2.ap.freescale.net>
References: <20120619130145.GD10387@shlinux2.ap.freescale.net>
 <1340111993-6676-1-git-send-email-b29396@freescale.com>
 <20120619140613.GH21951@S2101-09.ap.freescale.net>
 <20120620022313.GE10387@shlinux2.ap.freescale.net>
Message-ID: <20120620054015.GB1568@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 10:23:15AM +0800, Dong Aisheng wrote:
> I did see what you said, but you did not go with reasons and that was not so
> convinced to me
> Can you explain more why you choose linux virt irq and how about the real exist
> potential issues i raised before?
> 
It's not my choice.  Instead, this is how struct resource defined in
Linux.  What more reasons do you need to understand that?

I do not take the thing you raised as issues, because in the end all
these static definitions will be removed after we move over to device
tree.

> Hmm, it's not driver code.
> And i did see a lot of such code in mach-specific file.

That does not mean you are encouraged to add more.  We are trying to
remove them.

> If wrong, any other better way to distinguish the different SoCs?
> 
There are certainly better way, since we have soc specific
initialization to do all the soc specific setup.  That said, we do
not have to necessarily use all those ugly cpu_is_xxx and #ifdef.

> That is a way, but i would prefer to do it in mach-specific code first

No.  Do not make imx special on this.  We would like to use resource
definition in the way how it's defined and how everyone else use it.

> since i'm not sure if other people will also like that.

No one (except yourself) likes it.  As I said, we are not supposed to
manipulate resource definition this way.

-- 
Regards,
Shawn
