From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Nov 2018 17:27:16 +0100
Subject: [PATCH 23/27] arm: Add support for generic vDSO
In-Reply-To: <20181109123730.8743-24-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-24-vincenzo.frascino@arm.com>
Message-ID: <CAK8P3a2B4g64XM5O6mEKA=pr73SzJGxk0VKCs8Hifn-aj6Uv9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 9, 2018 at 1:38 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> +
> +static __always_inline notrace int gettimeofday_fallback(struct timeval *_tv,
> +                                                        struct timezone *_tz)
> +{
>
> +
> +static __always_inline notrace long clock_gettime_fallback(clockid_t _clkid,
> +                                                          struct timespec *_ts)

Same as for the arm64 compat version, these could use old_timeval32
and old_timespec32 right away.

       Arnd
