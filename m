From: pasha.tatashin@oracle.com (Pasha Tatashin)
Date: Fri, 11 Aug 2017 12:03:38 -0400
Subject: [v6 08/15] mm: zero struct pages during initialization
In-Reply-To: <20170811125047.GJ30811@dhcp22.suse.cz>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-9-git-send-email-pasha.tatashin@oracle.com>
 <20170811125047.GJ30811@dhcp22.suse.cz>
Message-ID: <f81f5eaa-109e-666e-7020-84c090721a56@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I believe this deserves much more detailed explanation why this is safe.
> What actually prevents any pfn walker from seeing an uninitialized
> struct page? Please make your assumptions explicit in the commit log so
> that we can check them independently.

There is nothing prevents pfn walkers from walk over any struct pages 
deferred and non-deferred. However, during boot before deferred pages 
are initialized we have just a few places that do that, and all of those 
cases are fixed in this patchset.

> Also this is done with some purpose which is the perfmance, right? You
> have mentioned that in the cover letter but if somebody is going to read
> through git logs this wouldn't be obvious from the specific commit.
> So add that information here as well. Especially numbers will be
> interesting.

I will add more performance data to this patch comment.
