From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 31 Jan 2015 07:41:20 +0200
Subject: [PATCH v7 1/4] Documentation: dt: add common bindings for
 hwspinlock
In-Reply-To: <CAJAp7Og+-KQd7bygWQjTS72Kye3fkp3s3ry+2bw7Gcv7aPF5AQ@mail.gmail.com>
References: <1421269101-51105-1-git-send-email-s-anna@ti.com>
 <1421269101-51105-2-git-send-email-s-anna@ti.com>
 <20150115135201.GG16217@leverpostej>
 <20150115135556.GH16217@leverpostej>
 <CAL_JsqL2LZAooMk-V8+xeF2g6acZE21M+-OBRw8aEVa-5wVHuQ@mail.gmail.com>
 <CAK=WgbYQ=BbinqJ5fsw2Y+FKdy=nasLsw9mX8pw6S_o3owy9-g@mail.gmail.com>
 <20150116101746.GA21809@leverpostej>
 <CAK=WgbYBqPoUm9byx0du_g5ZmHdYaUVLpSPZYHoCVzNoatNKpw@mail.gmail.com>
 <CAJAp7Og+-KQd7bygWQjTS72Kye3fkp3s3ry+2bw7Gcv7aPF5AQ@mail.gmail.com>
Message-ID: <CAK=WgbZ2986xxuAFvMSoyQLaPAxdUpZ8e5g-mSjyETfvd4KKHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 31, 2015 at 1:29 AM, Bjorn Andersson <bjorn@kryo.se> wrote:
> In a system where you have two hwlock blocks lckA and lckB, each
> consisting of 8 locks and you have dspB that can only access lckB

This is a good example - thanks. To be able to cope with such cases we
will have to pass a hwlock block reference and its relative lock id.

The DT binding should definitely be prepared for such cases (just kill
the base-id field?), but let's see what it means about the Linux
implementation.

Since the existence of several hwblocks is still fictional (Bjorn,
please confirm too?), we may prefer to introduce changes to support it
only when it shows up; it all depends on the amount of changes needed.
Suman, care to take a look please?

>> - Sometimes a remote processor, which may not be running Linux, will
>> have to dynamically allocate a hwlock, and send the ID of the
>> allocated lock to us (another processor running Linux)
>>
> I'm sorry but you cannot have a system on both sides that is allowed
> to do dynamic allocation from a limited set of resources.

Of course not. On such systems, Linux is not the one responsible for
allocating the hwlocks, at least not during part of the time or from
part of the hwlocks. There were a few different use cases, with
different semantics, that required communicating to Linux an hwlock
id, but since none of them have reached mainline, we should only
remember they may show up one day, but not put too much effort to
support them right now.

Thanks,
Ohad.
