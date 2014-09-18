From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 18 Sep 2014 10:02:49 -0700
Subject: [PATCH v5 1/4] thermal: rockchip: add driver for Thermal
In-Reply-To: <541A985C.6030301@rock-chips.com>
References: <1410926353-15674-1-git-send-email-caesar.wang@rock-chips.com>
 <1410926353-15674-2-git-send-email-caesar.wang@rock-chips.com>
 <20140917170223.GB25297@core.coreip.homeip.net>
 <541A985C.6030301@rock-chips.com>
Message-ID: <20140918170249.GC14809@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

On Thu, Sep 18, 2014 at 04:31:24PM +0800, Caesar Wang wrote:
> Dear Dmitry,
> 
> 
> ? 2014?09?18? 01:02, Dmitry Torokhov ??:
> >Hi Caesar,
> >
> >On Wed, Sep 17, 2014 at 11:59:10AM +0800, Caesar Wang wrote:
> >>+{
> >>+	int i;
> >>+
> >>+	for (i = 0; i < ARRAY_SIZE(v2_code_table) - 1; i++) {
> >>+		if (code >= v2_code_table[i].code)
> >>+			return v2_code_table[i].temp;
> >>+	}
> >>+
> >>+	return 0;
> >I think if we do not find the code we should be returning max
> >temperature, not 0.
> Agree.
> >And also WARN_ON() as this should not be happening.
> >
> Maybe,I will fix it as the follows:
> 
> pr_warn("Don't find code from v2_code_table\n");
> return 125;
> 
> Do you agree?

Sounds good.

Thanks.

-- 
Dmitry
