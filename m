From: mroos@linux.ee (Meelis Roos)
Date: Wed, 4 Dec 2013 15:08:39 +0200 (EET)
Subject: [PATCH v2] OF: base: match each node compatible against all
 given matches first
In-Reply-To: <20131204094010.GO19943@ulmo.nvidia.com>
References: <1385663785-8643-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1386078720-8756-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <alpine.SOC.1.00.1312032210480.25191@math.ut.ee> <529E614B.3070307@gmail.com>
 <20131204094010.GO19943@ulmo.nvidia.com>
Message-ID: <alpine.SOC.1.00.1312041506010.8902@math.ut.ee>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I added Meelis on Cc because he found a regression with my original
> proposal (107a84e61cdd "of: match by compatible property first"). That
> got later reverted in commit bc51b0c22ceb (Revert "of: match by
> compatible property first"). Here's the commit message for reference:
> 
> commit bc51b0c22ceb
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Tue Jul 10 12:49:32 2012 -0700
> 
>     Revert "of: match by compatible property first"
> 
>     This reverts commit 107a84e61cdd3406c842a0e4be7efffd3a05dba6.
> 
>     Meelis Roos reports a regression since 3.5-rc5 that stops Sun Fire V100
>     and Sun Netra X1 sparc64 machines from booting, hanging after enabling
>     serial console.  He bisected it to commit 107a84e61cdd.
> 
>     Rob Herring explains:
>      "The problem is match combinations of compatible plus name and/or type
>       fail to match correctly.  I have a fix for this, but given how late it
>       is for 3.5 I think it is best to revert this for now.  There could be
>       other cases that rely on the current although wrong behavior.  I will
>       post an updated version for 3.6."
> 
>     Bisected-and-reported-by: Meelis Roos <mroos@linux.ee>
>     Requested-by: Rob Herring <rob.herring@calxeda.com>
>     Cc: Thierry Reding <thierry.reding@avionic-design.de>
>     Cc: Grant Likely <grant.likely@secretlab.ca>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> So if Meelis still has access to the Sun Fire V100 and Sun Netra X1
> machines that regressed last time around, it'd be great to get this
> patch tested on them to verify that it indeed fixes the problem and
> doesn't regress.

OK, I had forgotten about that.

Tested successfully on the same Sun Fire V100 and Sun Netra X1, on top 
of 3.13-rc2. The sunsu console is detected fine and I see no problem for 
now.

-- 
Meelis Roos (mroos at linux.ee)
