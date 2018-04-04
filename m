From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 4 Apr 2018 13:24:26 +0300
Subject: [alsa-devel] [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
In-Reply-To: <20180403134540.GA29017@lenoch>
References: <20180330154420.6903-1-colin.king@canonical.com>
 <20180403134540.GA29017@lenoch>
Message-ID: <20180404102425.cwj7vzvrvi2obcoi@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 03:45:40PM +0200, Ladislav Michl wrote:
> On Fri, Mar 30, 2018 at 04:44:20PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> 
> Hello Colin,
> 
> > Trivial fix to spelling mistake in pr_debug message text
> 
> would you mind making this patch a bit less non-trivial and
> change pr_debug to dev_dbg dropping Atmel_ssc_dai prefix?
> 
> Thank you.
>

Trivial patches should just be trivial instead of evolving into a thread
that lasts for days.

I sometimes write trivial clean up patches for things like:

arch/x86/lib/csum-partial_64.c:97 do_csum() warn: inconsistent indenting
    88                          /* last up to 7 8byte blocks */
    89                          count %= 8; 
    90                          while (count) { 
    91                                  asm("addq %1,%0\n\t"
    92                                      "adcq %2,%0\n" 
    93                                              : "=r" (result)
    94                                      : "m" (*(unsigned long *)buff), 
    95                                      "r" (zero),  "0" (result));
    96                                  --count; 
    97                                          buff += 8;
    98                          }

Why is "buff += 8;" indented too far?  And why does every line end in a
space character?  And I think about it for 10 minutes and then delete my
patch because it's too much hassle to deal with for something small.

regards,
dan carpenter
