From: tiny.windzz@gmail.com (Frank Lee)
Date: Wed, 21 Nov 2018 00:08:58 +0800
Subject: [PATCH v2] cpuidle: big.LITTLE: add of_node_put()
In-Reply-To: <CAJZ5v0hWSCDbDUV1_iQBf-4Y=QgnBTrAqQqcCyOpv9r7yCjGiQ@mail.gmail.com>
References: <20181120154617.20903-1-tiny.windzz@gmail.com>
 <CAJZ5v0hWSCDbDUV1_iQBf-4Y=QgnBTrAqQqcCyOpv9r7yCjGiQ@mail.gmail.com>
Message-ID: <CAEExFWv289bsEc-2OXcVkhnHv_UsOU1YnKt6Mv-nFqM_QN+PVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 12:06 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Nov 20, 2018 at 4:46 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > The of_node_put() is missing.So we call the of_node_put() to release
> > the refcount.
>
> I would say "of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it."
>
> Thanks,
> Rafael
Hi Rafael?

You are right, I will change it right away.

Yours?
    Yangtao
