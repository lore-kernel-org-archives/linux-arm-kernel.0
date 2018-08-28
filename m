From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Tue, 28 Aug 2018 18:17:48 +0530
Subject: [PATCH 04/15] soc: octeontx2: Add mailbox support infra
In-Reply-To: <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com>
Message-ID: <CA+sq2CeyQ8r7bj3vK=cfriif=HhUu36ZUPWqxXm1e0DktHG+Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 5:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 28, 2018 at 12:57 PM <sunil.kovvuri@gmail.com> wrote:
> >
> > From: Aleksey Makarov <amakarov@marvell.com>
> >
> > This patch adds mailbox support infrastructure APIs.
> > Each RVU device has a dedicated 64KB mailbox region
> > shared with it's peer for communication. RVU AF has
> > a separate mailbox region shared with each of RVU PFs
> > and a RVU PF has a separate region shared with each of
> > it's VF.
> >
> > These set of APIs are used by this driver (RVU AF) and
> > other RVU PF/VF drivers eg netdev, crypto e.t.c.
> >
> > Signed-off-by: Aleksey Makarov <amakarov@marvell.com>
> > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > Signed-off-by: Lukasz Bartosik <lbartosik@marvell.com>
>
> Why does this driver not use the drivers/mailbox/ infrastructure?
>
>        Arnd

This is a common administrative software driver which will be handling requests
from kernel drivers and as well as drivers in userspace applications.
We had to keep
mailbox communication infrastructure same across all usages.

Thanks,
Sunil.
