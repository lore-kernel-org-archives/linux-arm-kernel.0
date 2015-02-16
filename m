From: bjorn@kryo.se (Bjorn Andersson)
Date: Mon, 16 Feb 2015 12:30:37 -0800
Subject: [PATCH v7 1/4] Documentation: dt: add common bindings for
 hwspinlock
In-Reply-To: <CAK=WgbZ2986xxuAFvMSoyQLaPAxdUpZ8e5g-mSjyETfvd4KKHw@mail.gmail.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
 <1421269101-51105-2-git-send-email-s-anna@ti.com>
 <20150115135201.GG16217@leverpostej>
 <20150115135556.GH16217@leverpostej>
 <CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com>
 <CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>
 <20150116101746.GA21809@leverpostej>
 <CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com>
 <CAJAp7Og+-KQd7bygWQjTS72Kye3fkp3s3ry+2bw7Gcv7aPF5AQ@mail.gmail.com>
 <CAK=WgbZ2986xxuAFvMSoyQLaPAxdUpZ8e5g-mSjyETfvd4KKHw@mail.gmail.com>
Message-ID: <CAJAp7OjvFj6RL=Z=SQ6XYzo4qd-Bhe3SYV9-JAGS5SzjJ6R5xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 9:41 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
[..]
> Since the existence of several hwblocks is still fictional (Bjorn,
> please confirm too?), we may prefer to introduce changes to support it
> only when it shows up; it all depends on the amount of changes needed.
> Suman, care to take a look please?
>

It turns out that the Qualcomm platforms have two additional "remote
spinlock" mechanisms - both using shared memory.

On most platforms only 1 (out of these 3) is actually consumed, but
e.g. the older msm7x30 uses 2 of them (SMEM and DAL). Due to its age I
don't think it's on anyones todo list to actually support this
platform as of today; but it's out there.


None of these hwlocks are allocated dynamically, so if needed a
dynamic base_id (-1 like other frameworks) would be a acceptable
solution - and can easily be implemented when we need it.

Regards,
Bjorn
