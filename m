From: ak@linux.intel.com (Andi Kleen)
Date: Sat, 16 Dec 2017 10:47:01 -0800
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <5d322353-2785-a99f-bcd8-b948bd6cb09a@huawei.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
 <20171206133607.GA12508@krava>
 <c46d07bc-a6f0-1b01-0595-a615781f8cff@huawei.com>
 <20171208122918.GE2799@krava>
 <afd7bf2a-4d94-0db0-640d-b1c93c8ba230@huawei.com>
 <20171209073104.GB14297@krava>
 <5d322353-2785-a99f-bcd8-b948bd6cb09a@huawei.com>
Message-ID: <20171216184701.GB25156@tassilo.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Won't this all potentially have a big maintainence cost?

No. It's all auto generated.

The only cost is slightly bigger binary size.

I would hope your event files are auto generated too.

> I just don't know how this schema scales with more archs and more platforms
> supported. It's just early days now...

Only perf will get slightly bigger, but memory is not exactly expensive.

In fact, the extra memory won't even be faulted in if it's not used,
so it's only disk space.

-Andi
