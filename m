From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Wed, 1 Jun 2011 09:57:15 +0200
Subject: [PATCH 2/3] clocksource: add DB8500 PRCMU Timer support
In-Reply-To: <BANLkTinPKbUu40066+wr3cdFRc2di-Uv6g@mail.gmail.com>
References: <1306830661-9546-1-git-send-email-mattias.wallin@stericsson.com>	<alpine.LFD.2.02.1105311236250.3078@ionos>	<4DE51EB7.7010606@stericsson.com>
	<BANLkTinPKbUu40066+wr3cdFRc2di-Uv6g@mail.gmail.com>
Message-ID: <4DE5F0DB.2050409@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2011 11:18 PM, Linus Walleij wrote:
> Does it work to register the clocksource with say a core_initcall()
> and avoid the header altogether?
I wanted the init to be called from the struct sys_timer init call. 
Mainly because it is really early and it seems to be what others do but 
if we now want to move things out of the platform code it might make 
sense to remove that dependency.
I'll experiment with it during the day and see how it goes.
