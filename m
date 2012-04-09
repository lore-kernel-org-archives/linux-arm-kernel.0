From: khilman@ti.com (Kevin Hilman)
Date: Mon, 09 Apr 2012 15:56:54 -0700
Subject: [PATCH 06/17][V2] ARM: OMAP4: cpuidle - use the omap4_idle_data
 variable directly
In-Reply-To: <1333570371-1389-7-git-send-email-daniel.lezcano@linaro.org>
 (Daniel Lezcano's message of "Wed, 4 Apr 2012 22:12:40 +0200")
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
 <1333570371-1389-7-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <87r4vw8qfd.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> We are storing the 'omap4_idle_data' in the private data field
> of the cpuidle device. As we are using this variable only in this file,
> that does not really make sense. Let's use the global variable directly
> instead dereferencing pointers in an idle critical loop.

Did you notice a performance impact before this change?   

> Also, that simplfies the code.

possibly, but at the expense of clean abstractions which IMO helps readability.

Unless there is a real performance hit here (which I doubt), I'd prefer
to leave this as is.

Kevin
