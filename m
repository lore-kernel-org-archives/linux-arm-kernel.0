From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 11 Aug 2015 17:54:34 +0200
Subject: [PATCH 9/15 V2] drivers: rtc: Drop (un)likely before
 IS_ERR(_OR_NULL)
In-Reply-To: <b8be698a8625ceb9adc8da51cd9474626db7c3d1.1438339891.git.viresh.kumar@linaro.org>
References: <cdfa3fb76901fe1c4a5756e7e64cb3370cf6317a.1438331416.git.viresh.kumar@linaro.org>
 <b8be698a8625ceb9adc8da51cd9474626db7c3d1.1438339891.git.viresh.kumar@linaro.org>
Message-ID: <20150811155434.GT3411@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/2015 at 16:23:43 +0530, Viresh Kumar wrote :
> IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
> is no need to do that again from its callers. Drop it.
> 
> gemini driver was using likely() for a failure case while the rtc driver
> is getting registered. That looks wrong and it should really be
> unlikely. But because we are killing all the unlikely() flags, lets kill
> that too.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - Removed the likely() part from gemini driver and the changelog wasn't
>   updated to match that. Fixed the changelog now.
> 
>  drivers/rtc/interface.c  | 2 +-
>  drivers/rtc/rtc-bfin.c   | 2 +-
>  drivers/rtc/rtc-gemini.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
