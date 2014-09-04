From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 04 Sep 2014 11:39:27 +0200
Subject: [PATCH 04/19] serial: samsung: Remove support for legacy clock
 code
In-Reply-To: <53C68FAB.9070102@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
 <1404496099-26708-5-git-send-email-t.figa@samsung.com>
 <1405502840.4408.2.camel@x220> <53C67386.5070401@samsung.com>
 <1405520767.4408.39.camel@x220> <1405521324.4408.44.camel@x220>
 <53C68FAB.9070102@samsung.com>
Message-ID: <1409823567.5546.80.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-16 at 16:43 +0200, Tomasz Figa wrote:
> On 16.07.2014 16:35, Paul Bolle wrote:
> > On Wed, 2014-07-16 at 16:26 +0200, Paul Bolle wrote:
> >> On Wed, 2014-07-16 at 14:43 +0200, Tomasz Figa wrote:
> >>> That's right. Apparently I missed them. I guess that's not critical,
> >>> though, and could be done in separate patch, right?
> >>
> >> This is not critical at all, so that's fine with me. 
> > 
> > Actually, that's only correct if the solution here is to just remove the
> > (currently) dead code hidden behind CONFIG_SAMSUNG_CLOCK. But if the
> > solution requires something less trivial, that might be quite wrong.
> > 
> > So please disregard my comment!
> 
> The code between those ifdefs is no longer used, because all Samsung
> platforms use the Common Clock Framework after this series. So I believe
> we can safely remove this dead code.

The three checks for CONFIG_SAMSUNG_CLOCK can still be seen in v3.17-rc3
and next-20140903. Should I perhaps submit the trivial patch to remove
them (and the code they hide) or did things turn out to be more
complicated?


Paul Bolle
