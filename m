From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 5 Feb 2015 16:34:06 -0800
Subject: [PATCH v7 1/4] Documentation: dt: add common bindings for
 hwspinlock
In-Reply-To: <54D406BA.6060403@ti.com>
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
 <CAJAp7OjVULNRd113TtOEwaa6QO-XCDa0oxBm2H5NPvp_kLTSpA@mail.gmail.com>
 <54CFE71E.20905@ti.com>
 <CAJAp7OiHfaMrVqaZ1r6ZN0aMMpE4OUnvLhODHQJeb6EJMa+o8A@mail.gmail.com>
 <54D406BA.6060403@ti.com>
Message-ID: <CAJAp7Ojud6UM97eDYdUhZxzzjNRw_47e5kqh4UxwDBMwFZpuoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 5, 2015 at 4:11 PM, Suman Anna <s-anna@ti.com> wrote:
> Hi Bjorn,
>
> On 02/05/2015 05:01 PM, Bjorn Andersson wrote:
[..]
>> Will you send out a new revision of the binding? I would love to get
>> this integrated so I can move on with the dependents.
>
> Yep, will do as soon as I hear from Ohad on what to do with the patch
> "hwspinlock/core: maintain a list of registered hwspinlock banks" that I
> dropped from v7. Without that and dropping hwlock-base-id, I can't get
> the translations done.
>

My suggestion is to replace the global id-tree with a list of hwlocks
and iterate over these if we ever get more than one driver registered.
As long as #hwlock-drivers < log(#total-hwlocks) this should be
faster.

I would however argue that clients that would notice any kind of
difference are using the API incorrectly.


Unfortunately this is a somewhat larger change than just slapping DT
support on the framework :/

Regards,
Bjorn
