From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 19 May 2015 18:10:58 -0700
Subject: [PATCHv8 01/10] watchdog: Rename watchdog_active to
 watchdog_hw_active
In-Reply-To: <1432023969-20736-2-git-send-email-timo.kokkonen@offcode.fi>
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
 <1432023969-20736-2-git-send-email-timo.kokkonen@offcode.fi>
Message-ID: <555BDF22.2090208@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2015 01:26 AM, Timo Kokkonen wrote:
> Before extending the watchdog core midlayer, it is useful to rename
> the watchdog_active function so that it states explicitly what it
> really does. That is, "active" watchdog means really that the watchdog
> hardware is running and needs pinging to prevent a watchdog reset
> taking place in near future.
>
> This is different to "watchdog open" state, which simply states that
> kernel is expecting the user space to keep the watchdog alive. These
> states might become different mainly because some hardware have
> limitations that prevent them from being stopped at will.
>

I don't see why this is needed. If you need another state, per your
description, it would be "open" in addition to "active".

Guenter
