From: balbi@ti.com (Felipe Balbi)
Date: Thu, 27 Jun 2013 13:06:21 +0300
Subject: [PATCH 2/4] ARM: OMAP5: clockdomain data: add init file for
 omap54xx
In-Reply-To: <51CC04C9.3050801@ti.com>
References: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
 <1372322299-25046-3-git-send-email-t-kristo@ti.com>
 <20130627084434.GT15455@arwen.pp.htv.fi> <51CC04C9.3050801@ti.com>
Message-ID: <20130627100621.GA510@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Thu, Jun 27, 2013 at 12:24:25PM +0300, Tero Kristo wrote:
> On 06/27/2013 11:44 AM, Felipe Balbi wrote:
> >Hi,
> >
> >On Thu, Jun 27, 2013 at 11:38:17AM +0300, Tero Kristo wrote:
> >>+	rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
> >>+	abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");
> >
> >should these two lines be swaped ?
> 
> No, its a different clock. clk_set_parent is done for a clock that is
> a parent of dpll_abe_ck.

hah, just now I noticed clk_set_parent() has abe_dpll_ref, not abe_dpll
as argument :-p

> >>+	if (!rc)
> >>+		rc = clk_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ);
> >>+	if (rc)
> >>+		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
> >>+
> >>+	return 0;
> >
> >so even if (rc) you still return 0 ? Shouldn't you return rc instead ?
> 
> Hmm yea, this could be improved. :) Same should be done for O4 / DRA7
> also. Seems like a long lasting feature actually.

I see... ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130627/34d5b833/attachment.sig>
