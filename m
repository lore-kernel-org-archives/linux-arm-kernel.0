From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Nov 2010 14:35:16 -0800
Subject: [PATCH] OMAP: UART: don't resume UARTs that are not enabled.
In-Reply-To: <1290631720.15533.30.camel@eowin>
References: <1290625743-8370-1-git-send-email-khilman@deeprootsystems.com>
	<1290631720.15533.30.camel@eowin>
Message-ID: <20101124223516.GX31536@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <me@felipebalbi.com> [101124 12:39]:
> Hi,
> 
> On Wed, 2010-11-24 at 11:09 -0800, Kevin Hilman wrote:
> > Add additional check to omap_uart_resume_idle() so that only
> > enabled (specfically, idle-enabled) UARTs are allowed to resume.
> 
> typo: specifically

Also, without this patch, system with PM enabled hangs in
cases where only one serial port is initialized instead of
all of them. So I'll queue it as a fix during the -rc cycle.

Regards,

Tony
