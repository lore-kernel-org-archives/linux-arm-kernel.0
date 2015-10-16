From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Oct 2015 12:09:48 -0700
Subject: [PATCH v2 1/3] ARM: OMAP2: DRA7: Modify optimize string
 comparisons in soc_is calls
In-Reply-To: <1444885808-6306-2-git-send-email-j-keerthy@ti.com>
References: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
 <1444885808-6306-2-git-send-email-j-keerthy@ti.com>
Message-ID: <20151016190948.GB24370@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [151014 22:14]:
> Currently everytime soc_is calls are made, firstly device tree nodes
> are parsed and then string comparisons are made to determine the
> soc version. Optimizing it to be done one time and store the result.
> Use the stored value in all the subsequent checks for soc_is calls.

Let's just get rid of the of_machine_is_compatible() checks here.

When dra7xxx_check_revision we already know it's dra7, no point for
any of the string parsing with of_machine_is_compatible(). We just
risk things going wrong.

And we already have omap_revision that gets populated based on the
hawkeye register, so let's use that instead. Can you please update
this patch just to use is_dra7xx() macros like the other use?

Regards,

Tony
