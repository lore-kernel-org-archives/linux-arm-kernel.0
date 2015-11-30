From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 30 Nov 2015 20:04:31 +0100
Subject: [PATCH 1/3] rtc: sunxi: fix signedness issues
In-Reply-To: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20151130190431.GK22136@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/2015 at 11:50:08 +0100, LABBE Corentin wrote :
> The variable year must be set as unsigned since it is used with
> sunxi_rtc_data_year{.min|.max} and as parameter of is_leap_year() which
> wait for unsigned int.
> Only tm_year is not unsigned, but it is long.
> This patch fix also the format of printing of min/max. (must use %u since
> they are unsigned)
> 
> The parameter to of sunxi_rtc_setaie() must be set to uint since callers
> give always uint data.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/rtc/rtc-sunxi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
