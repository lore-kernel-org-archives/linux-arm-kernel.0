From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 Sep 2016 20:26:02 +0100
Subject: [PATCH] arm: dts: fix rk3066a based boards vdd_log voltage
 initialization
In-Reply-To: <20160922201301.0157a292@bbrezillon>
References: <CAD=FV=Ufmvg1P8suOPQ53kpOD1pei4N2dOpKUCxZk001XKj_OA@mail.gmail.com>
 <20160919194844.0db7b307@bbrezillon>
 <CAD=FV=UyW5cXGGmq5xUzZ1aV5NzbBYGOz1gO9V1itrFU-PigAw@mail.gmail.com>
 <20160919200627.3ca1aae4@bbrezillon>
 <CAD=FV=U_BQez2eCqm7mX9kj0dcEsnBKiFWcLAhXXJD+yTZhACw@mail.gmail.com>
 <20160919224352.3b84b6c0@bbrezillon>
 <CAD=FV=W=ZiaLu1=zcnDyUqvK6f=E-0AWH9URHE3cgAKWWa+aJA@mail.gmail.com>
 <20160922171217.09a6d13f@bbrezillon>
 <20160922164752.GP7994@sirena.org.uk>
 <20160922201301.0157a292@bbrezillon>
Message-ID: <20160922192602.GV7994@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2016 at 08:13:01PM +0200, Boris Brezillon wrote:

> So, there are 2 different problems here:
> 1/ the board no longer boots because of commit 87248991a1de and a
>    missing entry in the voltage table
> 2/ claiming the PWM pins at probe time can cause glitches

> I'm currently trying to solve #1, but most of the discussion in this
> thread was about addressing #2.

Well, if you actually want the entry in the voltage table then adding it
does seem the most sensible fix.

> > That was a very
> > long e-mail so I might be missing something but the obvious thing seems
> > to be to force a state since we'll be doing that when we enable anyway.

> Hm, okay, but which state should we choose? The first entry in the
> voltage-table?

That's why we don't do this currently.  Probably the closest one if we
can work out what it was trying to achieve.

> > Or just not have the voltage table and use it as a continuous regulator.

> Yes, but that means patching the DT, which means breaking the DT compat.

It sounds like you want to fix the DT anyway though?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160922/adb328ef/attachment.sig>
