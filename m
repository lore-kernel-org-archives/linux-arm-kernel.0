From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 1 Aug 2013 22:16:49 +0300
Subject: [Ksummit-2013-discuss] [ARM ATTEND] catching up on exploit
 mitigations
In-Reply-To: <20130801190556.GA1495@redhat.com>
References: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
 <20130801091322.GA5302@mwanda> <20130801190556.GA1495@redhat.com>
Message-ID: <20130801191649.GB5102@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 03:05:56PM -0400, Dave Jones wrote:
> On Thu, Aug 01, 2013 at 12:13:22PM +0300, Dan Carpenter wrote:
>  > I was just reading http://faultlinux.lip6.fr/ which says that in
>  > 2011 the static checker fault rate in arch/ and fs/ was worse than
>  > in drivers/
> 
> I've been working on getting more regular builds in coverity, so we can
> get more meaningful statistics on things like "what area is getting worse".
> 
> Of the current bugs I've categorised so far, here's the breakdown for 3.11-rc3
> in terms of highest bug counts.
> 
> Drivers/net/wireless: 659 
> Drivers/ [1] : 600
> Drivers/staging: 449
> Drivers/scsi: 409
> Drivers/net: 350
> Net/[2] : 297
> Drivers/media: 286
> Sound: 220
> Drivers/GPU: 217
> 
> That's the top categories for the whole kernel.
> 
> That wireless was top of the list was the least shocking thing to me,
> based on what we get reported to Fedora bugzilla.  That it found more
> bugs there than in staging was amusing though. The good news is that
> wireless also takes the top slot for 'resolved' issues.
> 
> The paper above talks about 'arch' but doesn't indicate if it's counting
> all arches, or just the one they run the tests on. (Coverity only covers x86,
> so arch/ shows up in 10th place there).

It's Coccinelle, so my guess is they ran it on all the .c files.

regards,
dan carpenter
