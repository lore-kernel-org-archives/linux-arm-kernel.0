From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Mon, 10 Oct 2011 22:54:09 +0400
Subject: [PATCH] leds-class: change back LEDS_CLASS to tristate instead
	of bool
In-Reply-To: <1317113432-7299-1-git-send-email-bryan.wu@canonical.com>
References: <1317113432-7299-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <20111010185409.GA8787@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 04:50:32PM +0800, Bryan Wu wrote:
> LEDS_CLASS is required by leds and trigger drivers, but we can build it as
> module.  So change this option back as tristate and treak the help message
> as well.
> 
> LEDS_TRIGGERS depends on LEDS_CLASSS, which should be tristate.  So set it
> as tristate too and update header files as well.
> 
> Change those ifdefs to take care of module configuration.
> 
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>

Won't this break linking if POWER_SUPPLY=y and LEDS_TRIGGERS=m?

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
