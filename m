From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 19 Dec 2012 17:10:33 +1300
Subject: Inconsistency in clk framework
Message-ID: <1355890233.25599.4.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

In attempting to remove some IS_ERR_OR_NULL references, it was pointed
out that clk_get() can return NULL if CONFIG_HAVE_CLK is not defined.

This seems to contradict the kernel docs associated with the normal
clk_get (when HAVE_CLK is defined) which states:

* Returns a struct clk corresponding to the clock producer, or
* valid IS_ERR() condition containing errno.

Wouldn't a return code of ERR_PTR(-ENOENT) make more sense and be inline
with the empty of_ versions as well (which return -ENOENT when CONFIG_OF
is undefined).

Also, I noticed that clk_get_sys() doesn't appear to be defined in clk.h
when HAVE_CLK is undefined - is this correct?

Regards
Tony Prisk
