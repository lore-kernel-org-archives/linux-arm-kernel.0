From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 28 Mar 2012 10:33:21 +0530
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <201203271359.16553.arnd@arndb.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203271159.35306.arnd@arndb.de>
 <CAOh2x==7gNt2Jb3-EHz9-R1pTy6zL93FmUmTBMdpYUnW3F=9Uw@mail.gmail.com>
 <201203271359.16553.arnd@arndb.de>
Message-ID: <4F729B99.4020909@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/27/2012 7:29 PM, Arnd Bergmann wrote:
> That would be even better. I think we should generally try do initialization
> as late as possible, ideally from initcalls. The init_early() function should
> only be used for code that absolutely has to be run from setup_arch() and
> no later, while the map_io() function should ideally only be used to set up
> the static mappings and nothing else.

I remember now why we do it in map_io().
Timers need clock support and they are up before machine_init() is called.

So, i believe i must have DT_MACHINE_START per SoC.

I will post V2 for 3xx DT support today, but can i have initial level of review
from you, so that i can fixup minor issues in V2 only?

-- 
viresh
