From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 1 Feb 2015 13:00:13 +0200
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
Message-ID: <CAK=WgbZFZXcHuZUFVg4aAwjqzTQQxpV+Hp-DUYPKg5D8AsQ4Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 31, 2015 at 7:41 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Sat, Jan 31, 2015 at 1:29 AM, Bjorn Andersson <bjorn@kryo.se> wrote:
> > In a system where you have two hwlock blocks lckA and lckB, each
> > consisting of 8 locks and you have dspB that can only access lckB
>
> This is a good example - thanks. To be able to cope with such cases we
> will have to pass a hwlock block reference and its relative lock id.

Additionally, to support such a scenario, we can no longer retain the
simple dynamic allocation API we have today, because it might end up
allocating dspB an hwlock from IckA.

We will have to make sure hwlocks are allocated only from pools
visible to the user, something that will change not only the
hwspinlock API but also the way it maintains the hwlocks.

I suspect we want to wait for such hardware to show up first, and only
then add framework support for it. Regardless, we obviously do want to
make sure our DT binding is prepared for the worse, so we'll drop the
"base-id" field.

Thanks,
Ohad.
