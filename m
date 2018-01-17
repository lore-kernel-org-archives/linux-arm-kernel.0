From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 17 Jan 2018 16:14:17 -0500 (EST)
Subject: [PATCH] ARM: make memzero optimization smarter
In-Reply-To: <nycvar.YSQ.7.76.1801170859210.13881@knanqh.ubzr>
References: <20180116162905.1404585-1-arnd@arndb.de>
 <nycvar.YSQ.7.76.1801161205560.13881@knanqh.ubzr>
 <CAK8P3a2bfErHxu2i-3JJpUdG64RSoYgmpip2xLAutiSSM9UEkw@mail.gmail.com>
 <nycvar.YSQ.7.76.1801162150190.13881@knanqh.ubzr>
 <20180117105815.GL17719@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1801170859210.13881@knanqh.ubzr>
Message-ID: <nycvar.YSQ.7.76.1801171606170.13881@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Jan 2018, Nicolas Pitre wrote:

> On Wed, 17 Jan 2018, Russell King - ARM Linux wrote:
> 
> > However, __memzero is not safe against being called with a zero length
> > so it's not something we can simply remove.
> 
> The idea is about the possibility of removing __memzero altogether.
> It is not clear that the tiny performance gain from a dedicated memzero 
> implementation is worth the current overhead around it.

This being said, I fail to see how __memzero is not safe against a zero 
length. Are you sure it isn't?


Nicolas
