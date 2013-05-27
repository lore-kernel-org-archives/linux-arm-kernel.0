From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 May 2013 14:47:35 +0200
Subject: [PATCH 1/2] ARM: kirkwood: proper retain MAC address workaround
 on DT ethernet
In-Reply-To: <1369655404.3557.33.camel@pasglop>
References: <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <51A33447.80305@gmail.com> <1369655404.3557.33.camel@pasglop>
Message-ID: <2255648.0KEmXfjCx5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 May 2013 21:50:04 Benjamin Herrenschmidt wrote:
> However, that wouldn't help much with the allocation/leak problem,
> though at least it would be easier to use. It could also *try* to re-use
> the current allocation if the new content is of smaller or equal size.

I thought that dtc tried to aggressively save space by folding identical
strings. If you tried to reuse a property that had its contents shared
with another one, you would get interesting results I guess.

	Arnd
