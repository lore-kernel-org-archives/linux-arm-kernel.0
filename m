From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 10 Jul 2014 16:55:35 +0200
Subject: [PATCH 2/6] tty: serial: 8250 core: allow to overwrite & export
 serial8250_startup()
In-Reply-To: <1404928177-26554-3-git-send-email-bigeasy@linutronix.de>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de>
 <1404928177-26554-3-git-send-email-bigeasy@linutronix.de>
Message-ID: <53BEA967.4070200@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2014 07:49 PM, Sebastian Andrzej Siewior wrote:
> The OMAP version of the 8250 can actually use 1:1 serial8250_startup().
> However it needs to be extended by a wakeup irq which should to be
> requested & enabled at ->startup() time and disabled at ->shutdown() time.
> 
> v1?v2: add shutdown callback

forgot to copy the callbacks in serial8250_register_8250_port().

Sebastian
