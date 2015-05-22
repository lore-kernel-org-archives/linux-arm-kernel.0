From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 22 May 2015 09:27:07 +0300
Subject: [PATCHv3 10/10] CLK: TI: always enable DESHDCP clock
In-Reply-To: <alpine.DEB.2.02.1505210254330.7960@utopia.booyaka.com>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
 <1430906938-26128-11-git-send-email-tomi.valkeinen@ti.com>
 <555C744C.6070901@ti.com> <555C74E8.5010105@ti.com>
 <555CE1BF.4050506@codeaurora.org>
 <alpine.DEB.2.02.1505210254330.7960@utopia.booyaka.com>
Message-ID: <555ECC3B.6000701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/05/15 06:06, Paul Walmsley wrote:

>> Enable falls under the "critical clocks" discussion that is ongoing. I
>> assume that this is some sort of critical clock that can't be turned off?
> 
> It only needs to be enabled for this particular display IP subsystem to 
> function:
> 
> http://marc.info/?l=linux-omap&m=142071550111482&w=2
> 
> I believe Tomi is taking this approach (enabling it unconditionally) to 
> avoid adding support for a secondary IP block "main clock" to the hwmod 

Right. I don't think that would be a simple task (correct me if I'm
wrong), and that would all be only for this one IP on this particular
SoC type.

> code.  Apparently, the chips that contain this clock gating bit are not 
> intended to be used for power-critical use cases, so there's not much 
> motivation to switch it on and off with the display controller.

Even in power-critical use cases the the power use difference should be
negligible.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150522/ab09ead1/attachment.sig>
