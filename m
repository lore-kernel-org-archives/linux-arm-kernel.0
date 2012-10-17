From: lliubbo@gmail.com (Bob Liu)
Date: Wed, 17 Oct 2012 10:26:07 +0800
Subject: dma_alloc_coherent fails in framebuffer
In-Reply-To: <1350398501.2532.12.camel@dabdike>
References: <1350192523.10946.4.camel@gitbox> <1350246895.11504.6.camel@gitbox>
 <20121015094547.GC29125@suse.de> <1350325704.31162.16.camel@gitbox>
 <CAA_GA1cPE+m8N1LQA2iOym4jbFwcHG+K2p-3iBovPWuf1N1q+g@mail.gmail.com>
 <1350398501.2532.12.camel@dabdike>
Message-ID: <CAA_GA1d_twVqv9jOGx74wvYiuJwQQDAN-NJB_x61df=--yP6Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 10:41 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Tue, 2012-10-16 at 10:17 +0800, Bob Liu wrote:
>> I think you need to declare that memory using
>> dma_declare_coherent_memory() before
>> alloc_from_coherent.
>
> This isn't true.  Almost every platform has a mechanism for
> manufacturing coherent memory (in the worst case, they just turn off the
> CPU cache on a page and hand it out).  The purpose of
> dma_declare_coherent_memory() is to allow a per device declaration of
> preferred regions ... usually because they reside either on the fast
> path to the device or sometimes on the device itself.  There are only a
> handful of devices which need it, so in the ordinary course of events,
> dma_alloc_coherent() is used without any memory declaration.
>

Sorry for my ambiguity.
It obviously true we can use dma_alloc_coherent() without any memory
declaration.

I thought Tony's original idea was want to make
dma_alloc_from_coherent() return success.
But the dev->dma_mem check can't pass, so i suggested him using
dma_declare_coherent_memory()
to declare per-device area first.

Thanks,
--Bob
