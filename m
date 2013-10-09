From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 9 Oct 2013 16:39:39 +0300
Subject: [PATCH 1/3] ARM: OMAP4: use CLK_SET_RATE_PARENT for dss_dss_clk
In-Reply-To: <5255587F.5010601@ti.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
 <5255587F.5010601@ti.com>
Message-ID: <52555C9B.20607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/13 16:22, Tero Kristo wrote:
> On 10/09/2013 04:12 PM, Tomi Valkeinen wrote:
>> Set CLK_SET_RATE_PARENT flag for dss_dss_clk so that the DSS's fclk can
>> be configured without the need to get the parent of the fclk.
> 
> I wouldn't touch this file right now, as we are trying to move the clock
> data over to DT. Legacy boot support probably requires to do this
> update, but I would rather wait a bit and do the modifications to both
> DT clock data and this file in the same patch. Same applies for other
> patches also.

Sounds good. I don't have any particular wishes how this is done, but
I'd really like these to go into 3.13.

The fclk handling in omapdss is quite a mess, and these flags would make
it possible to clean it up. And the reason it's important to clean up
the fclk handling ASAP is AM43xx, which has yet another clocking scheme.

If these get only to 3.14, then I can fix the fclk handling only on 3.15.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131009/23da6f88/attachment.sig>
