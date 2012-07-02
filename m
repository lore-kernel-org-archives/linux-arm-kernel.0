From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 2 Jul 2012 15:25:22 +0300
Subject: [PATCH] remoteproc: block premature rproc booting
In-Reply-To: <CAK=WgbZo-8GXY9bVYGk0XZvqKrdaJZWeNkK1FhRWnH5doGYLjA@mail.gmail.com>
References: <1337687472-23009-1-git-send-email-ohad@wizery.com>
 <4FBDFC4A.1060602@codeaurora.org>
 <CAK=WgbaP5qSso_Eu=Oup4eqLDcorZ-qf=mysMKiEvOS=m7yLmg@mail.gmail.com>
 <4FCD276A.80505@codeaurora.org>
 <CAK=WgbZo-8GXY9bVYGk0XZvqKrdaJZWeNkK1FhRWnH5doGYLjA@mail.gmail.com>
Message-ID: <CAK=WgbZb367zq0QCUuwFU+KtBY0gw_+rsN9fm2YnM-heT+54jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Sjur, Ludovic, Loic

On Tue, Jun 5, 2012 at 1:57 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Tue, Jun 5, 2012 at 12:23 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> I thought we wanted to allow both calls to proceed in parallel? If we
>> don't care about that
>
> Yeah, I don't think we do.
>
>> then "announcing" it once the firmware is found the first time sounds correct.
>
> I agree. Though this patch may be moot very soon due to:
>
>>> The main reason we kept the get/put interface was to make it easier
>>> for you guys to adopt it, but I've been re-thinking lately whether we
>>> really want that interface. It's a problematic interface with
>>> non-negligible maintenance burden, and the code will be greatly
>>> simplified without it.
>>
>> If nobody in the kernel is using it why keep it?
>
> I was concerned that the non get/put interface might not suit
> everyone, and I planned to wait for another user or two to show up
> before I remove that interface.
>
> Since MSM's PIL is based on a get/put interface, I actually hoped to
> see if you guys can adopt the new interface before we ditch the
> get/put one.
>
>> If MSM needs we can add it back when we move to rproc.
>
> Thanks - that's the kind of feedback I wanted to get.

Sjur, Ludovic, Loic - what remoteproc API are you using today?

We'd like to get rid of the existing get/put interface and instead
have everyone use the boot/shutdown one, just like rpmsg is doing
today.

Are you ok with this change?

Thanks,
Ohad.
