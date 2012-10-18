From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Oct 2012 15:28:03 -0700
Subject: [PATCH 01/10] pinctrl: use postcore_initcall
In-Reply-To: <5080802B.3000209@wwwdotorg.org>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <5080802B.3000209@wwwdotorg.org>
Message-ID: <20121018222802.GG30550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [121018 15:20]:
> On 10/18/2012 03:06 AM, Haojian Zhuang wrote:
> > Since pins are configured in device driver, pinctrl driver should be
> > loaded by those device driver. module_platform_driver() only declares
> > pinctrl driver is in module_initcall privilege. Use postcore_initcall
> > privilege instead.
> 
> I'm not convinced this is needed; doesn't deferred probe sort out the
> dependencies correctly?

I'm a bit concerned about this need too as the trend is towards
initializing things later than earlier. The drivers/Makefile order
and deferred probe should be already enough?

Specifically could you decribe the cases where this issue happens?
Also check if one of your client drivers has some early initcall
that's no longer needed.

Regards,

Tony
