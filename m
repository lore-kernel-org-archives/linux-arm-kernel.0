From: rientjes@google.com (David Rientjes)
Date: Mon, 16 Jun 2014 18:25:45 -0700 (PDT)
Subject: [PATCH] arm: Fix build warning
In-Reply-To: <1402677635-28406-1-git-send-email-linux@roeck-us.net>
References: <1402677635-28406-1-git-send-email-linux@roeck-us.net>
Message-ID: <alpine.DEB.2.02.1406161825360.21018@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jun 2014, Guenter Roeck wrote:

> If compiled with W=1, the following warning is seen in arm builds.
> 
> arch/arm/kernel/topology.c:278:25: warning:
> 	type qualifiers ignored on function return type
> 
> This is caused by a function returning 'const int', which doesn't
> make sense to gcc. Drop 'const' to fix the problem.
> 
> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: David Rientjes <rientjes@google.com>
