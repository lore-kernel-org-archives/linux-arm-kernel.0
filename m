From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Oct 2012 16:18:19 -0600
Subject: [PATCH 01/10] pinctrl: use postcore_initcall
In-Reply-To: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <5080802B.3000209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2012 03:06 AM, Haojian Zhuang wrote:
> Since pins are configured in device driver, pinctrl driver should be
> loaded by those device driver. module_platform_driver() only declares
> pinctrl driver is in module_initcall privilege. Use postcore_initcall
> privilege instead.

I'm not convinced this is needed; doesn't deferred probe sort out the
dependencies correctly?
