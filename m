From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Feb 2014 18:41:48 -0500
Subject: [PATCH] rtc: mv: reset date if after year 2038
In-Reply-To: <1392729966-25394-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392729966-25394-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140221234148.GO7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 02:26:06PM +0100, Thomas Petazzoni wrote:
> Dates after January, 19th 2038 are badly handled by userspace due to
> the time being stored on 32 bits. This causes issues on some Marvell
> platform on which the RTC is initialized by default to a date that's
> beyond 2038, causing a really weird behavior of the RTC.
> 
> In order to avoid that, reset the date to a sane value if the RTC is
> beyond 2038.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/rtc/rtc-mv.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied to mvebu/drivers with Baruch's grammar fix.

thx,

Jason.
