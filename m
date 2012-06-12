From: fengguang.wu@intel.com (Fengguang Wu)
Date: Tue, 12 Jun 2012 19:09:29 +0800
Subject: [linux-next] "clk: add non CONFIG_HAVE_CLK routines" commit
In-Reply-To: <CAOh2x=mFOPKbzuY__k0RVpFHTdPfa-iN1e3Lpa3iWt9iP6FzFw@mail.gmail.com>
References: <20120522234621.GA3610@windriver.com>
 <CAOh2x=mFOPKbzuY__k0RVpFHTdPfa-iN1e3Lpa3iWt9iP6FzFw@mail.gmail.com>
Message-ID: <20120612110929.GA16511@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Following are present in mach-netx/fb.c:
[snip]
> struct clk *clk_get(struct device *dev, const char *id)
> {
> 	return dev && strcmp(dev_name(dev), "fb") == 0 ? NULL : ERR_PTR(-ENOENT);
> }
> 
> I can remove first four without any issues, but just can't remove the last one.
> The dummy clk_get() always returns NULL, whereas this one returns NULL only for
> fb device.
> 
> How should I fix this?

Another thing I'm not sure is that the typical clk_get() callers only
tests IS_ERR() on the returned value. As a clk newbie, I don't know
whether there will be lots of clk users seeing this (new) NULL value
on !CONFIG_HAVE_CLK and whether the current behavior is correct..

Thanks,
Fengguang
