From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 03 Nov 2015 18:40:31 -0600
Subject: [PATCH v2 1/2] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <20151103160410.34bbebc805c17d2f41150a19@linux-foundation.org>
 (Andrew Morton's message of "Tue, 3 Nov 2015 16:04:10 -0800")
References: <1446574204-15567-1-git-send-email-dcashman@android.com>
 <20151103160410.34bbebc805c17d2f41150a19@linux-foundation.org>
Message-ID: <87k2pyppfk.fsf@x220.int.ebiederm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue,  3 Nov 2015 10:10:03 -0800 Daniel Cashman <dcashman@android.com> wrote:
>
>> ASLR currently only uses 8 bits to generate the random offset for the
>> mmap base address on 32 bit architectures. This value was chosen to
>> prevent a poorly chosen value from dividing the address space in such
>> a way as to prevent large allocations. This may not be an issue on all
>> platforms. Allow the specification of a minimum number of bits so that
>> platforms desiring greater ASLR protection may determine where to place
>> the trade-off.
>
> Can we please include a very good description of the motivation for this
> change?  What is inadequate about the current code, what value does the
> enhancement have to our users, what real-world problems are being solved,
> etc.
>
> Because all we have at present is "greater ASLR protection", which doesn't
> really tell anyone anything.

The description seemed clear to me.

More random bits, more entropy, more work needed to brute force.

8 bits only requires 256 tries (or a 1 in 256) chance to brute force
something.

We have seen in the last couple of months on Android how only having 8 bits
doesn't help much.

Each additional bit doubles the protection (and unfortunately also
increases fragmentation of the userspace address space).

Eric
