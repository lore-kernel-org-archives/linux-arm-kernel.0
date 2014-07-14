From: cl@gentwo.org (Christoph Lameter)
Date: Mon, 14 Jul 2014 10:13:56 -0500 (CDT)
Subject: [RFC/PATCH -next 00/21] Address sanitizer for kernel (kasan) -
 dynamic memory error detector.
In-Reply-To: <CAPAsAGwb2sLmu0o_o-pFP5pXhMs-1sZSJbA3ji=W+JPOZRepgg@mail.gmail.com>
References: <1404903678-8257-1-git-send-email-a.ryabinin@samsung.com>
 <53C08876.10209@zytor.com>
 <CAPAsAGwb2sLmu0o_o-pFP5pXhMs-1sZSJbA3ji=W+JPOZRepgg@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1407141012520.25405@gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 13 Jul 2014, Andrey Ryabinin wrote:

> > How does that work when memory is sparsely populated?
> >
>
> Sparsemem configurations currently may not work with kasan.
> I suppose I will have to move shadow area to vmalloc address space and
> make it (shadow) sparse too if needed.

Well it seems to work with sparsemem / vmemmap? So non vmmemmapped configs
of sparsemem only. vmemmmap can also handle holes in memory.
