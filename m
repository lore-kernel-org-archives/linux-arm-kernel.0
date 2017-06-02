From: panand@redhat.com (Pratyush Anand)
Date: Fri, 2 Jun 2017 20:02:25 +0530
Subject: [PATCH v3 0/2] kexec-tools: arm64: Enable D-cache in purgatory
In-Reply-To: <CAKv+Gu-0p6iWnY9fr67YrYUgiLwArwkNUKio-7XjT0uMafcQ-w@mail.gmail.com>
References: <cover.1495514291.git.panand@redhat.com> <59312080.1090906@arm.com>
 <CAKv+Gu--N4Pef6z=G4ePTgF3CcKhmmSfrvJBY-5p0CLL_PZ=3Q@mail.gmail.com>
 <CAFTCetS17w0-BJJzTfi8uNS67xos4MwJz3R=qdz2Oe7+fcXk3g@mail.gmail.com>
 <CAKv+Gu86EEFzVzG4h0f6sBk=ar4Ffv_KuNhyKNi_Zf7k3KvWcg@mail.gmail.com>
 <CAKv+Gu-0p6iWnY9fr67YrYUgiLwArwkNUKio-7XjT0uMafcQ-w@mail.gmail.com>
Message-ID: <2b80fca3-b462-a1b5-36db-e8b8b8fdc126@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

Thanks for all the inputs.

On Friday 02 June 2017 05:14 PM, Ard Biesheuvel wrote:
>> Alternatively, a SHA-256 implementation that uses movz/movk sequences
>> instead of ldr instructions to load the round constants would already
>> be 5x faster, given that we don't need page tables to enable the
>> I-cache.
> Actually, looking at the C code and the objdump of the kernel's
> sha256_generic driver, it is likely that it is already doing this, and
> none of the points I made actually make a lot of sense ...
>
> Pratyush: I assume you are already enabling the I-cache in the purgatory?

It's not enabled yet. But, I had tried first with enabling only I-cache, but 
that did not make much difference in execution time.

~Pratyush
