From: viresh.linux@gmail.com (viresh kumar)
Date: Wed, 7 Mar 2012 04:13:57 -0800
Subject: [PATCH 14/15] watchdog/mpcore_wdt: Add clock framework support
In-Reply-To: <20120307111711.GA31348@bnru02>
References: <cover.1331115751.git.viresh.kumar@st.com>
 <9ec7141baa4b1c1a0503893749e7ce0e19bb5029.1331115752.git.viresh.kumar@st.com>
 <20120307111711.GA31348@bnru02>
Message-ID: <CAOh2x=mcaiSqYW7+9dsNoEhOazrud7BHp5095iqmrgy6iZ4utw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/7/12, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> wrote:
> On Wed, Mar 07, 2012 at 11:27:55 +0100, Viresh KUMAR wrote:
>> +	wdt->boot_status = (readl(wdt->base + TWD_WDOG_RESETSTAT) &
>> +			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
>> +
>
> I see that patch 12/15 does this, why are you doing it here again in clock
> patch?
>

>>
>> -	wdt->boot_status = (readl(wdt->base + TWD_WDOG_RESETSTAT) &
>> -			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
>> -
>
> oh, you delete this stuff here again.
>
> something messy in patch creation?

Yes. It does look messy. But it was intentional to move this code up
in the function.
Will move clk patch before IOCTL addition patch to make it clean.

--
viresh
