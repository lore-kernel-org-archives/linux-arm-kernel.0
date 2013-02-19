From: hughd@google.com (Hugh Dickins)
Date: Tue, 19 Feb 2013 11:06:15 -0800 (PST)
Subject: Should a swapped out page be deleted from swap cache?
In-Reply-To: <5122C9B3.10306@gmail.com>
References: <CAFNq8R4UYvygk8+X+NZgyGjgU5vBsEv1UM6MiUxah6iW8=0HrQ@mail.gmail.com>
 <alpine.LNX.2.00.1302180939200.2246@eggly.anvils> <5122C9B3.10306@gmail.com>
Message-ID: <alpine.LNX.2.00.1302191056390.2248@eggly.anvils>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Feb 2013, Will Huck wrote:
> 
> Another question:

I don't see the connection to deleting a swapped out page from swap cache.

> 
> Why kernel memory mapping use direct mapping instead of kmalloc/vmalloc which
> will setup mapping on demand?

I may misunderstand you, and "kernel memory mapping".

kmalloc does not set up a mapping, it uses the direct mapping already set up.

It would be circular if the basic page allocation primitives used kmalloc,
since kmalloc relies on the basic page allocation primitives.

vmalloc is less efficient than using the direct mapping (repeated setup
and teardown, no use of hugepages), but necessary when you want a larger
virtual array than you're likely to find from the buddy allocator.

Hugh
