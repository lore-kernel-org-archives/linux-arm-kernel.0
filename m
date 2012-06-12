From: viresh.kumar2@arm.com (viresh kumar)
Date: Tue, 12 Jun 2012 15:21:20 +0100
Subject: [linux-next] "clk: add non CONFIG_HAVE_CLK routines" commit
In-Reply-To: <20120612140801.GA7918@n2100.arm.linux.org.uk>
References: <20120522234621.GA3610@windriver.com>
 <CAOh2x=mFOPKbzuY__k0RVpFHTdPfa-iN1e3Lpa3iWt9iP6FzFw@mail.gmail.com>
 <20120612140801.GA7918@n2100.arm.linux.org.uk>
Message-ID: <4FD75060.9020805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/12 15:08, Russell King - ARM Linux wrote:
> On Tue, Jun 12, 2012 at 11:57:07AM +0100, viresh kumar wrote:
>> struct clk *clk_get(struct device *dev, const char *id)
>> {
>>      return dev && strcmp(dev_name(dev), "fb") == 0 ? NULL : ERR_PTR(-ENOENT);
>> }
>>
>> I can remove first four without any issues, but just can't remove the
>> last one.  The dummy clk_get() always returns NULL, whereas this one
>> returns NULL only for fb device.
>
> This isn't a totally dummy clk implementation.  What it's doing is returning
> a dummy clock for the framebuffer, and explicitly failing everything else
> (because we have no need to support any other clocks.)
>
> If we want to use the dummy clk stuff in its entirety, and just return the
> dummy clock for all clk_get()s on this platform, then there isn't a problem.
> If we want to keep this behaviour, we need to use clkdev with the dummy
> clk implementation.

First one is easier and I would go with that, if maintainer of that file/module
accepts it.

@Sascha: Are you maintaining this module?

--
Viresh

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
