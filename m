From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 18 Nov 2009 11:03:38 +0800
Subject: [PATCH] hx4700: fix hx4700 touchscreen pressure values
In-Reply-To: <E1NAYJo-00016g-PW@pih-relay04.plus.net>
References: <E1NAYJo-00016g-PW@pih-relay04.plus.net>
Message-ID: <f17812d70911171903v230b1598mc8e5ff2a4b5195b8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2009 at 8:22 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
>> Does pressure actually work as expected -- that is not inverted?
>> Because I need this patch on spitz... ?but it may break your
>> machine...
>
> You are right, the pressure values were being inverted on my hx4700.
> Pressing hard generates somewhat lower Rt values than pressing lightly.
>
> Since typical hx4700 Rt values are close to (pressure_max/2) anyway,
> the inverted and non-inverted values were not very different.
> For example:
>
> Rt ? ? ?ts->pressure_max-Rt
> 599 ? ? 425
> 562 ? ? 462
> 588 ? ? 436
> 570 ? ? 454
>
> So by all means submit your ads7846.c patch; it will not break hx4700.
>

Is this generically true that the pressure is always inverted? Otherwise
a platform specific field indicating this would be the better way to go.

- eric
