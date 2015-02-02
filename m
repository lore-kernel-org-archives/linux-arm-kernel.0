From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 02 Feb 2015 12:03:50 -0800
Subject: [RFC 1/2] clocksource: track usage
In-Reply-To: <1421399874-29119-2-git-send-email-alexandre.belloni@free-electrons.com>
 (Alexandre Belloni's message of "Fri, 16 Jan 2015 10:17:53 +0100")
References: <1421399874-29119-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421399874-29119-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <7ha90wqdw9.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:

> Track whether the clocksource is enabled or disabled.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  include/linux/clocksource.h |  4 ++++
>  kernel/time/clocksource.c   | 26 ++++++++++++++++++++++++++
>  kernel/time/timekeeping.c   |  8 +++-----
>  3 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index abcafaa20b86..7735902fc5f6 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -210,6 +210,8 @@ struct clocksource {
>  #define CLOCK_SOURCE_SUSPEND_NONSTOP		0x80
>  #define CLOCK_SOURCE_RESELECT			0x100
>  
> +#define CLOCK_SOURCE_USED			0x200

minor nit: How about s/USED/ENABLED/ so the flag name is similar to the
function names.

Kevin 
