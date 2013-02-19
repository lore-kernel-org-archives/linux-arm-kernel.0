From: per.lkml@gmail.com (Per Forlin)
Date: Tue, 19 Feb 2013 13:05:16 +0100
Subject: sg_is_chain() call in coh901318_lli_fill_sg()
In-Reply-To: <510F9C79.4090108@acm.org>
References: <510F9C79.4090108@acm.org>
Message-ID: <CAFEEs1ni5J8__q2FGi4QvbS6Sz_dWCk20O5S9AE0UNQhvULP9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bart,

On Mon, Feb 4, 2013 at 12:33 PM, Bart Van Assche <bvanassche@acm.org> wrote:
> Hello,
>
> I'm trying to understand how coh901318_lli_fill_sg() works by studying the
> source code of that function. In that function I found the following code:
>
>         for_each_sg(sgl, sg, nents, i) {
>                 if (sg_is_chain(sg)) {
>                         [ ... ]
>
> Can anyone explain me why that construct makes sense ?
I think the answer is: it doesn't make sense.

> As far as I can see
> in lib/scatterlist.c sg_next() ensures that the for_each_sg() skips those
> elements for which sg_is_chain(sg) == true. Does that mean that
> sg_is_chain(sg) always evaluates to false in the above loop ?
Yes, I agree. I'm guilt of adding this check a long time ago due to sg
misconceptions. Today I no longer recall what the misconception was.
Linus, you may remove this check.

Thanks for spotting this,
Per
