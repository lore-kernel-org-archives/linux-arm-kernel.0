From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 8 May 2015 13:15:27 -0700
Subject: [PATCH] ARM: tegra: add "nor-jedec" flash compatible binding
In-Reply-To: <554D1624.5030608@wwwdotorg.org>
References: <1431066098-19821-1-git-send-email-zajec5@gmail.com>
 <554CDD8C.7050000@wwwdotorg.org>
 <20150508184317.GZ32500@ld-irv-0074>
 <554D1624.5030608@wwwdotorg.org>
Message-ID: <20150508201527.GC32500@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 02:01:40PM -0600, Stephen Warren wrote:
> On 05/08/2015 12:43 PM, Brian Norris wrote:
> >On Fri, May 08, 2015 at 10:00:12AM -0600, Stephen Warren wrote:
> >>Equally, "nor-jedec" doesn't sound like the right name. It doesn't
> >>differentiate between SPI and parallel NOR flash, which presumably
> >>need different compatible values, since the programming model is
> >>quite different, and the compatible value is supposed to
> >>define/imply the SW-visible programming model.
> >
> >It's definitely for SPI only. There was much discussion about this a
> >few months back. Somewhere along the way, it was mentioned that the
> >context (SPI slave is a child of SPI master) would make this clear. I'm
> >still not sure why we didn't end up with something more descriptive,
> >though, like "spi-nor,nor-jedec".
> >
> >I'm open to change, as this binding is new in 4.1-rc1.
> 
> I don't believe compatible values should be interpreted according to
> context; compatible value matching isn't implemented that way AFAIK,
> and I'm not aware of any precedent for it to work that way.

For SPI slaves, they are always nested within their SPI master/bus node.
The master driver chooses how to probe its children. So there is some
context-sensitivity.

> Did the discussion involve the core DT maintainers? If so, whatever
> they decided can stick. Otherwise, the discussion should be rubn by
> them.

Yes. I never got an "ack", but Mark Rutland commented a few times and
didn't seem to object to the name. e.g.:

http://lists.infradead.org/pipermail/linux-mtd/2015-March/058275.html

Brian
