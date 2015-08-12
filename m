From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 12 Aug 2015 15:39:19 -0700
Subject: enabling libgcc for 64-bit divisions, was Re: PROBLEM: XFS on ARM
 corruption 'Structure needs cleaning'
In-Reply-To: <CA+55aFx3-8LRR9aFDM-CrunSEFrSs+z_=iAZ6n-+wgNRzJ4NQQ@mail.gmail.com>
References: <5579B804.9050707@skylable.com>
 <20150612122108.GB60661@bfoster.bfoster>
 <557AD4D4.3010901@skylable.com> <20150612225209.GA20262@dastard>
 <C6D0D499B56584katsuki.uwatoko@toshiba.co.jp>
 <20150812062445.GA4520@infradead.org>
 <CA+55aFxcoXkaa1syBVxwb9-bn3rfyFam9fcNY438bkhHjHq+Vw@mail.gmail.com>
 <55CBC6C6.3090306@kernel.org>
 <CA+55aFx3-8LRR9aFDM-CrunSEFrSs+z_=iAZ6n-+wgNRzJ4NQQ@mail.gmail.com>
Message-ID: <CALCETrVP1a+NMC1tGLSGQef4eeWHGgFLLh=ayNLrpoMOCWctJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 3:36 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Aug 12, 2015 at 3:20 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>
>> Does your objection still apply if we supplied our own implementations of a
>> handful of libgcc helpers?
>
> We already do that.
>
> Several architectures actually implement _udivdi3.
>
> However, do_div() is actually the much simpler/better interface.
>
> I don't think we have a single case in the kernel where we really want
> the full 64/64 division, and the 64/32->64 case really is
> fundamentally simpler.
>
> This whole "do_div is so complicated" thing is just BS.
>
> The thing that triggered Christoph to ask was a bug in the
> implementation of that *simpler*  interface. What makes you think that
> making people implement _udivdi3 would magically avoid all such bugs?
>

Nothing.

We could ask gcc to fix this, I suppose (add __udiv_64_over_32 or whatever).

--Andy
