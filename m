From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 22 Jun 2016 12:36:18 +0200
Subject: [PATCH 1/2] cpufreq: exynos: use relaxed IO accesors
In-Reply-To: <3668897.kYSEflAvDO@wuerfel>
References: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
 <3668897.kYSEflAvDO@wuerfel>
Message-ID: <CAJKOXPfFaAq4te5Jp2sXkK7MfS-NxmWnx931dDojFfBW34ofeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 11:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, June 22, 2016 10:33:03 AM CEST Ben Dooks wrote:
>> The use of __raw IO accesors is not endian safe and should be used
>> sparingly. The relaxed variants should be as lightweight and also
>> are endian safe.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>
>
> Why not use the normal readl/writel() here instead of the relaxed version?
>
> Either one should work here, but in general I'd recommend using the
> non-relaxed version unless code is particularly performance sensitive.
>
> The main argument for that is to not let people get used to using
> _relaxed() all the time because it causes some very hard to debug
> problems in the cases where you actually need the barriers.

I think that would be actually different patch, not endian related.
The concurrent operations here are excluded by mutexes so this looks
safe.

Viresh,
I saw your ack. Do you prefer me to take the set through samsung-soc?

Best regards,
Krzysztof
