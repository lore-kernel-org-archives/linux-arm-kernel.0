From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 9 Oct 2013 16:33:43 +0300
Subject: [PATCH 3/3] ARM: OMAP3: fix dpll4_m3_ck and dpll4_m4_ck dividers
In-Reply-To: <525558AA.9050906@ti.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
 <1381324359-28825-3-git-send-email-tomi.valkeinen@ti.com>
 <525558AA.9050906@ti.com>
Message-ID: <52555B37.80407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/13 16:22, Tero Kristo wrote:
> On 10/09/2013 04:12 PM, Tomi Valkeinen wrote:
>> dpll4_m3_ck and dpll4_m4_ck have divider bit fields which are 6 bits
>> wide. However, only values from 1 to 32 are allowed. This means we have
>> to add a divider tables and list the dividers explicitly.
>>
>> I believe the same issue is there for other dpll4_mx_ck clocks, but as
>> I'm not familiar with them, I didn't touch them.
> 
> I think you can limit the max value with a mask only, no need to define
> new tables.

The bit field is 6 bits wide, so the mask is correct. It's just that the
biggest allowed value is 32, which takes 6 bits, not 63.

Changing the mask to 5 bits would limit the divider to 31, wouldn't it?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131009/f34d44f6/attachment-0001.sig>
