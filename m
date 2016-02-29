From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 10:32:39 +0100
Subject: [PATCH] [RFC] mm/page_ref,
 crypto/async_pq: don't put_page from __exit
In-Reply-To: <CAAmzW4N0YJc_O9ArC8e7Q5y4rmbHjj6-Q1yfvZ5LvORvG764cg@mail.gmail.com>
References: <1456696663-2340682-1-git-send-email-arnd@arndb.de>
 <CAAmzW4N0YJc_O9ArC8e7Q5y4rmbHjj6-Q1yfvZ5LvORvG764cg@mail.gmail.com>
Message-ID: <2604022.UWS8hJ6Ygv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 February 2016 16:40:02 Joonsoo Kim wrote:
> 
> Hello, Arnd.
> 
> I think that we can avoid this error by using __free_page().
> It would not be inlined so calling it would have no problem.
> 
> Could you test it, please?

Yes, I suspect the driver should have done that anyway, new patch
under way.

	Arnd
