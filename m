From: tony@atomide.com (Tony Lindgren)
Date: Mon, 29 Jul 2013 02:08:22 -0700
Subject: [PATCH 3/4] pinctrl: Add support for additional dynamic states
In-Reply-To: <51E98D89.9050407@wwwdotorg.org>
References: <20130716090310.5541.36777.stgit@localhost>
 <20130716090536.5541.36289.stgit@localhost>
 <51E70B5D.6030802@wwwdotorg.org>
 <20130718073638.GP7656@atomide.com>
 <51E84180.6080902@wwwdotorg.org>
 <20130719073957.GZ7656@atomide.com> <51E91516.2040301@ti.com>
 <51E98D89.9050407@wwwdotorg.org>
Message-ID: <20130729090822.GZ7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [130719 12:10]:
> On 07/19/2013 04:29 AM, Grygorii Strashko wrote:
> > 
> > First of all, I'd like to mention that these patches do *not* connect
> > pinctrl to PM runtime, so until driver will call pinctrl_select_state()
> > or pinctrl_pm_select_*() there will be no pins state changes.
> 
> Isn't the whole point of the pinctrl_pm_select*() APIs to eventually be
> called automatically by the runtime PM core, so that we don't need to
> write code to do this in every single driver, just like we moved the
> call to pinctrl_select_state(default) into the device core so that we
> didn't have to make every device do that manually?

Yes I think we can make it all automatic. So far it seems that the
last missing piece was Linus' suggestion of making it mostly happen
using irqchip with calls to pinctrl so consumer drivers may not need
to do anything.
 
> > (As result, i2c-mux is not good example, seems:))
> 
> As such, I think all situations are good examples, because a generic
> feature has to work in all cases.

Yes we need to support both runtime PM, and more complex cases of
sharing pins between devices for example that are not runtime PM
related.

Regards,

Tony
