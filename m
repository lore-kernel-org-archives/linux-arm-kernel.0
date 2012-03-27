From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 27 Mar 2012 15:57:42 +0530
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <201203221420.10127.arnd@arndb.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203211236.37891.arnd@arndb.de>
 <CAOh2x=k6ZfamB8DnPgVPjxZ7E1gTuHOQYg6s1Nd1ybA+TSquWA@mail.gmail.com>
 <201203221420.10127.arnd@arndb.de>
Message-ID: <4F71961E.2080208@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/22/2012 7:50 PM, Arnd Bergmann wrote:
> The direct replacement is of_machine_is_compatible(), but there are a lot
> of cases where it's better to have a local property in the device node
> that a driver is using.

Hey Arnd,

I used of_machine_is_compatible() at several places, where it is not working :(
Actually all these usages are before a call to of_platform_populate() and
it looks the tree is not up by this time.

So, of_machine_is_compatible() always fails. The places where i am using this
routine are:
- spear3xx_dt_init(): to call SoC specific of_platform_populate()
- spear3xx_clk_init(): to call SoC specific clk_register()

Can you please suggest what should i do here?

-- 
viresh
