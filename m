From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 27 Jun 2013 12:24:25 +0300
Subject: [PATCH 2/4] ARM: OMAP5: clockdomain data: add init file for
 omap54xx
In-Reply-To: <20130627084434.GT15455@arwen.pp.htv.fi>
References: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
 <1372322299-25046-3-git-send-email-t-kristo@ti.com>
 <20130627084434.GT15455@arwen.pp.htv.fi>
Message-ID: <51CC04C9.3050801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2013 11:44 AM, Felipe Balbi wrote:
> Hi,
>
> On Thu, Jun 27, 2013 at 11:38:17AM +0300, Tero Kristo wrote:
>> +	rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
>> +	abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");
>
> should these two lines be swaped ?

No, its a different clock. clk_set_parent is done for a clock that is a 
parent of dpll_abe_ck.

>
>> +	if (!rc)
>> +		rc = clk_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ);
>> +	if (rc)
>> +		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
>> +
>> +	return 0;
>
> so even if (rc) you still return 0 ? Shouldn't you return rc instead ?

Hmm yea, this could be improved. :) Same should be done for O4 / DRA7 
also. Seems like a long lasting feature actually.

-Tero
