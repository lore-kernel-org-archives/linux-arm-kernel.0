From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Feb 2012 16:55:54 +0000
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <CACb=_tQ7M0DpfZ0FX+yA-pG_7hEyN_DQPBNM+BStaXrV5GQaMA@mail.gmail.com>
References: <1328088226-29594-1-git-send-email-lee.jones@linaro.org>
 <1328088226-29594-3-git-send-email-lee.jones@linaro.org>
 <CACb=_tQ7M0DpfZ0FX+yA-pG_7hEyN_DQPBNM+BStaXrV5GQaMA@mail.gmail.com>
Message-ID: <201202011655.54733.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 February 2012, Jamie Iles wrote:
> > +static struct ida soc_ida;
> > +static spinlock_t soc_lock;
> 
> Use DEFINE_IDR() and DEFINE_SPINLOCK() rather than initialising them at runtime?
> 

Good point! "static DEFINE_{IDR,SPINLOCK}()" even, in case that wasn't clear.

	Arnd
