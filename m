From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Fri, 29 Jun 2018 13:26:14 +0200
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <20180629110419.GC26019@e103592.cambridge.arm.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110419.GC26019@e103592.cambridge.arm.com>
Message-ID: <20180629112613.7i4xesjyxolc63gu@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 12:04:22PM +0100, Dave Martin wrote:
> 
> Can sparse be hacked to identify pointer subtractions where the pointers
> are cannot be statically proved to point into the same allocation?

sparse only see the (deatils of) the function it analyses and all
visible declarations, nothing more.

It would be more a job for smatch which do global analysis.
But to identify such subtractions yu must already have a (good)
pointer alias analysis which I don't think smatch do (but I can
be wrong, Dan & smatch's ml added in CC).

-- Luc Van Oostenryck
