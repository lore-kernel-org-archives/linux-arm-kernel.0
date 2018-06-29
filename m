From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 29 Jun 2018 16:42:57 +0300
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <20180629112613.7i4xesjyxolc63gu@ltop.local>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110419.GC26019@e103592.cambridge.arm.com>
 <20180629112613.7i4xesjyxolc63gu@ltop.local>
Message-ID: <20180629134257.ci5ninozkh2ni6wd@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 01:26:14PM +0200, Luc Van Oostenryck wrote:
> On Fri, Jun 29, 2018 at 12:04:22PM +0100, Dave Martin wrote:
> > 
> > Can sparse be hacked to identify pointer subtractions where the pointers
> > are cannot be statically proved to point into the same allocation?
> 
> sparse only see the (deatils of) the function it analyses and all
> visible declarations, nothing more.
> 
> It would be more a job for smatch which do global analysis.
> But to identify such subtractions yu must already have a (good)
> pointer alias analysis which I don't think smatch do (but I can
> be wrong, Dan & smatch's ml added in CC).

That would be hard to manage.  Maybe in a year from now...

Pointer math errors tend to get caught pretty quick because they're on
the success path so I don't imagine there are huge numbers of bugs.

regards,
dan carpenter
