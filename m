From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 20 Apr 2016 00:39:49 +0200
Subject: [PATCH 2/3] RTC: Write Calibration value before set time
In-Reply-To: <1460463346-24923-2-git-send-email-anuragku@xilinx.com>
References: <1460463346-24923-1-git-send-email-anuragku@xilinx.com>
 <1460463346-24923-2-git-send-email-anuragku@xilinx.com>
Message-ID: <20160419223949.GH29844@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2016 at 17:45:45 +0530, Anurag Kumar Vulisha wrote :
> It is suggested to programe CALIB_WRITE register with the calibration
> value before updating the SET_TIME_WRITE register, doing so will
> clear the Tick Counter and force the next second to be signaled
> exactly in 1 second.
> 
> This patch updates the same.
> 
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> ---
>  drivers/rtc/rtc-zynqmp.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
