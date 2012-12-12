From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 12 Dec 2012 11:28:01 +0100
Subject: [PATCH 06/10] ARM: OMAP2+: powerdomain/clockdomain: add a
 per-powerdomain spinlock
In-Reply-To: <20121209012340.19716.62316.stgit@dusk.lan>
References: <20121209011755.19716.25244.stgit@dusk.lan>
 <20121209012340.19716.62316.stgit@dusk.lan>
Message-ID: <CAORVsuX=az540kBsshEwJV_KM=Wp+y1uzVHbTp=EYvzbBqcutQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

-resending in plain text only, sorry about that-

On Sun, Dec 9, 2012 at 2:23 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Add a per-powerdomain spinlock.  Use that instead of the clockdomain
> spinlock.  Add pwrdm_lock()/pwrdm_unlock() functions to allow other
> code to acquire or release the powerdomain spinlock without reaching
> directly into the struct powerdomain.

Since clockdomains are part of powerdomains it seems weird for the
clockdomain code to take a powerdoamin lock.
Is there a reason why the powerdomain could not take the lock before
calling the clockdomain functions?

Also, are the lock and nolock version the clockdomain function needed?

Regards,
Jean
