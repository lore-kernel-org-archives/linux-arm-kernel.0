From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 18 Oct 2015 02:15:16 +0200
Subject: [PATCH v2] rtc: at91rm9200: clear RTC alarm status flag prior to
 suspending
In-Reply-To: <1444639163-14255-1-git-send-email-wenyou.yang@atmel.com>
References: <1444639163-14255-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20151018001516.GX3421@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2015 at 16:39:23 +0800, Wenyou Yang wrote :
> As said in the SAMA5D2 datasheet, "Prior to instructing the device
> to enter ULP mode 1, ... and the internal sources of wake-up must
> be cleared."
> 
> This patch is to clear the RTC alarm status flag prior to suspending
> to avoid the erroneous wake-up activity, as it is often used as
> the wake-up source for the ULP mode 1.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v2:
>  - Add more detail commit log.
> 
>  drivers/rtc/rtc-at91rm9200.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
