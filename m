From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 16 Oct 2017 23:43:29 +0530
Subject: [PATCH 9/9] ARM: multi_v7_defconfig: Statically build
 RTC_DRV_RK808
In-Reply-To: <3238534.Bk1TS2fSCp@diego>
References: <1508156187-27519-1-git-send-email-jagan@amarulasolutions.com>
 <1508156187-27519-10-git-send-email-jagan@amarulasolutions.com>
 <3238534.Bk1TS2fSCp@diego>
Message-ID: <CAMty3ZBcBAHTk5eQU99rRqYm7tQAjtuEaTT_q6J5FYmY=ybvOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 11:32 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi,
>
> Am Montag, 16. Oktober 2017, 17:46:27 CEST schrieb Jagan Teki:
>> RTC_DRV_RK808 need to have build statically for the platforms
>> do use MFB_RK808 so replace module with statical link.
>
> why would you need this to be compiled on? MFD_RK808 will happily
> just create the platform-devices which are then bound to the RTC
> driver later once the module is ready.

Yeah, that can be true but seems like rk808 need rtc at the
beginning(like boot time) because we observed the boot hang even with
gmac (like one with HDMI [1]) eventually booting continue only when it
linked statically.

[1] https://lkml.org/lkml/2017/9/4/224

thanks!
-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
