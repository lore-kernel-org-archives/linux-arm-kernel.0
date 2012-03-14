From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 14 Mar 2012 12:27:23 +0000
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F6008FA.3040805@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
Message-ID: <20120314122723.GC3133@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 02:57:00AM +0000, Tabi Timur-B04825 wrote:
> Mark Brown wrote:

> > With this card those would just be separate CODECs.  This is a binding
> > for a simple card.

> But that is insufficient for the SSI driver, which is expected to handle 
> multiple SSIs.  If you're going to document a binding for the SSI driver, 
> then you need to document how to handle multiple SSIs.

For almost all SoC audio ports this works in exactly the same way it
works for multiple instances of any other device - you do a binding that
covers a single device and then you bind multiple instances of that
device in the system each of which need know nothing about any other
instances of the IP.  

If your SoC has IP which provides more than one port in a single IP
block then the driver for that IP would need to register multiple DAIs
from a single binding which is again exactly the same thing as you'd do
with any other IP block that behaved similarly.

All of which is exactly the same as for any other device and essentially
irrelevant to how we define the bindings for the cards.

> > The biggest improvement is that the SoC binding knows nothing about the
> > card binding at all, cards are completely separate and are free to
> > define any binding they choose using any number of on-SoC and off-SoC
> > devices.

> Ok, I don't understand that at all.

Do you have some questions about the above?  What is it that you find
unclear?   

> I also don't understand why you insist on perverting my driver to support 
> two incompatible bindings, especially since I still haven't heard an 
> explanation as to what's wrong with the binding that I defined.

We've been through this *repeatedly*, including in the message you're
replying to, and we're still going back to square one every time you
decide to start talking about device tree again.  This is frustrating
in the extreme.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120314/52007cc3/attachment.sig>
