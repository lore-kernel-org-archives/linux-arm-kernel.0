From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 7 Apr 2015 15:16:50 +0300
Subject: [PATCHv2 03/10] ARM: DRA7: hwmod: set DSS submodule parent hwmods
In-Reply-To: <alpine.DEB.2.02.1504031902470.19540@utopia.booyaka.com>
References: <1427208910-17678-1-git-send-email-tomi.valkeinen@ti.com>
 <1427208910-17678-4-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1504031902470.19540@utopia.booyaka.com>
Message-ID: <5523CAB2.30807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/15 22:03, Paul Walmsley wrote:
> On Tue, 24 Mar 2015, Tomi Valkeinen wrote:
> 
>> Set DSS core hwmod as the parent for all the DSS submodules.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Thanks, queued.  Will send a pull request for this to Tony today, but it  
> may not make it for v4.1.  
> 
> Note that I cannot boot test this since I do not have a DRA7xx board.

As I mentioned in the reply to the pull request, we can't cherry pick
this patch, we need the HDCP clock.

This series should be changed so that the HDCP clock is handled in the
beginning of the series to keep bisect working. I'll do that for the
next version, which I probably would need to do in any case as Tero's
series is still under work.

Or if we want to get DRA7 DSS support in earlier, we could just use my
earlier simple patch which enables the HDCP clock.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150407/ee2b6a56/attachment.sig>
