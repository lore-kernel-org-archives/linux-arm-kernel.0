From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 16:00:44 +0100
Subject: [PATCH v2 05/18] reset: Add reset_controller_of_init() function
In-Reply-To: <1424455277-29983-6-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-6-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <8729383.kvUZDm4dQz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 February 2015 19:01:04 Maxime Coquelin wrote:
> Some platforms need to initialize the reset controller before the timers.
> 
> This patch introduces a reset_controller_of_init() function that can be
> called before the timers intialization.
> 
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> 

Not sure about this. It seems like the cleanest approach if we get
a lot of these, but then again it is probably very rare, and I'd
like to avoid adding such infrastructure if it's just for one
SoC. Could we add a hack in the machine initialization instead?

I think ideally this would be done in the boot loader before we
even start Linux, but I don't know if that's possible for you.

	Arnd
