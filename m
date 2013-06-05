From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 05 Jun 2013 14:13:23 +0200
Subject: [PATCH 15/15] OF: remove #ifdef from linux/of_platform.h
In-Reply-To: <CAL_JsqLRJ1cEWBfAdHEyngJHQKauJ6XzWH2JwXh1qDusMkzUGA@mail.gmail.com>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <201306041951.00447.arnd@arndb.de>
 <CAL_JsqLRJ1cEWBfAdHEyngJHQKauJ6XzWH2JwXh1qDusMkzUGA@mail.gmail.com>
Message-ID: <18275402.lrMAtEkNSk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 June 2013 17:24:51 Rob Herring wrote:
> 
> Right. I get all that. You still have to go add inlines if you want to make:
> 
> if (IS_ENABLED(CONFIG_OF))
>     of_foo();
> 
> just be:
> 
> of_foo();
> 
> There are situations for both and only inlines cover both cases. I
> don't see a reason we would want to allow the first case and not allow
> the second case. I am tired of taking patches adding the inlines 1 by
> 1, so perhaps we need to refactor the OF headers to better separate
> core infrastructure includes vs. driver only includes if that is
> really a concern.

Ok, fair enough. Putting internal declarations into a local header
file would be best of course.

	Arnd
