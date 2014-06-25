From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 25 Jun 2014 16:49:55 +0200
Subject: [PATCH v2] sched: Fix compiler warnings
In-Reply-To: <53AADC63.8080106@roeck-us.net>
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
 <20140625071416.GM14781@pengutronix.de>
 <53AADC63.8080106@roeck-us.net>
Message-ID: <20140625144955.GP14781@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Guenter,

On Wed, Jun 25, 2014 at 07:27:47AM -0700, Guenter Roeck wrote:
> >Maybe the author's intention was:
> >
> >	static inline int cpu_corepower_flags(void) __attribute__((const));
> >
> >?
> >This specifies that the function has no side effects and the return value
> >only depends on the (here non-existing) function arguments.
> >
> 
> Possibly, but either I am missing something or this doesn't compile.
You need to do a separate declaration:

	static inline int cpu_corepower_flags(void) __attribute__((const));
	static inline int cpu_corepower_flags(void)
	{
		...

Does this help?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
