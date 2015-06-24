From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Jun 2015 06:33:50 -0700
Subject: Use of pinctrl-single for external device over I2C
In-Reply-To: <558A9CC7.6070409@linaro.org>
References: <55893B2C.1070800@linaro.org>
 <558A9CC7.6070409@linaro.org>
Message-ID: <20150624133349.GI4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <vaibhav.hiremath@linaro.org> [150624 05:06]:
> On Tuesday 23 June 2015 04:25 PM, Vaibhav Hiremath wrote:
> >
> >/*
> >  * REVISIT: Reads and writes could eventually use regmap or something
> >  * generic. But at least on omaps, some mux registers are performance
> >  * critical as they may need to be remuxed every time before and after
> >  * idle. Adding tests for register access width for every read and
> >  * write like regmap is doing is not desired, and caching the registers
> >  * does not help in this case.
> >  */
> >
> >
> >Should be not have flag for this and use regmap_ variants? If we
> >implement flag based approach then same driver can be reused for pinmux
> >configuration of external device.

Nothing stopping you from adding regmap support to it. It just needs
to be made optional as the users so far don't need it.

Regards,

Tony
