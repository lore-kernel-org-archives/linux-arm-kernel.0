From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 17:36:30 +0200
Subject: [GIT PULL] STi defconfig changes for v4.2, round 2
In-Reply-To: <5554C747.6070604@st.com>
References: <5554C747.6070604@st.com>
Message-ID: <3099831.yDqamYD4m9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 May 2015 18:03:19 Maxime Coquelin wrote:
> ----------------------------------------------------------------
> STi defconfig for v4.2, round 2.
> 
> Highlights:
> -----------
>   - Enable STi PWM driver in multi_v7_defconfig
>   - Enable STi Power & Reset driver in multi_v7_defconfig
> 

The patches are both trivial, but please reconsider if you can make the
drivers loadable modules instead. We have in the past enabled all drivers
as built-in in multi_v7_defconfig, which has led to considerable growth,
so we'd prefer as much as possible to be modules now.

	Arnd
