From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 14 Feb 2014 16:01:48 +0200
Subject: [PATCH 7/8] ARM: dts: set 'ti,set-rate-parent' for dpll4_m4 path
In-Reply-To: <52FE2020.2010601@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
 <1392285846-13199-8-git-send-email-tomi.valkeinen@ti.com>
 <52FE2020.2010601@ti.com>
Message-ID: <52FE21CC.1010200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/02/14 15:54, Tero Kristo wrote:
> On 02/13/2014 12:04 PM, Tomi Valkeinen wrote:
>> Set 'ti,set-rate-parent' property for clocks in the dpll4_m4 clock
>> path, which is used for DSS functional clock. This fixes DSS driver's
>> clock rate configuration, which needs the rate to be propagated properly
>> to the divider node (dpll4_m4_ck).
> 
> 
> ... squash to #6?

I got no problem with that, but I think it's cleaner to separate these
two things. #6 converts the clock to use a different driver, and by
having these separate, it's easier to see that #6 converts the node 1:1
without other functional change.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140214/74d12cda/attachment.sig>
