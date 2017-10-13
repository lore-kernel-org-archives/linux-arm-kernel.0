From: pasha.tatashin@oracle.com (Pavel Tatashin)
Date: Fri, 13 Oct 2017 11:09:41 -0400
Subject: [PATCH v11 7/9] arm64/kasan: add and use kasan_map_populate()
In-Reply-To: <20171013144319.GB4746@arm.com>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171009221931.1481-8-pasha.tatashin@oracle.com>
 <20171010155619.GA2517@arm.com>
 <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
 <20171010171047.GC2517@arm.com>
 <CAOAebxtrSthSP4NAa0obBbsCK1KZxO+x0w5xNrpY6m2y9UZFvQ@mail.gmail.com>
 <CAOAebxu5WL-FQLgfCxNcWy36V6zsTO1v3LLqXv5rM1Pp9R-=YA@mail.gmail.com>
 <20171013144319.GB4746@arm.com>
Message-ID: <CAOAebxv4h+8ej6JA_DZbXaNV5JsAk4MbcCLf1+2RvwKGF2+MxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> It shouldn't be difficult to use section mappings with my patch, I just
> don't really see the need to try to optimise TLB pressure when you're
> running with KASAN enabled which already has something like a 3x slowdown
> afaik. If it ends up being a big deal, we can always do that later, but
> my main aim here is to divorce kasan from vmemmap because they should be
> completely unrelated.

Yes, I understand that kasan makes system slow, but my point is why
make it even slower? However, I am OK adding your patch to the series,
BTW, symmetric changes will be needed for x86 as well sometime later.

>
> This certainly doesn't sound right; mapping the shadow with pages shouldn't
> lead to problems. I also can't seem to reproduce this myself -- could you
> share your full .config and a pointer to the git tree that you're using,
> please?

Config is attached. I am using my patch series + your patch + today's
clone from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Also, in a separate e-mail i sent out the qemu arguments.

>
>> I feel, this patch requires more work, and I am troubled with using
>> base pages instead of large pages.
>
> I'm happy to try fixing this, because I think splitting up kasan and vmemmap
> is the right thing to do here.

Thank you very much.

Pavel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.gz
Type: application/x-gzip
Size: 36799 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171013/6c7f5e6d/attachment-0001.bin>
