From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 25 Mar 2015 00:30:33 +0100
Subject: [PATCH] ARM: force linker to use PIC veneers
In-Reply-To: <20150324232552.GW8656@n2100.arm.linux.org.uk>
References: <1427192184-31261-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150324122239.GB3579@e103592.cambridge.arm.com>
 <CAKv+Gu-MpvAnkEd2L_OPGpDv5cnCZACvzuQ9LbG8O5kjDRQUwQ@mail.gmail.com>
 <alpine.LFD.2.11.1503241112420.27567@knanqh.ubzr>
 <CAKv+Gu_kLtCqM1FtFRQdyBkzT3Rdqx90zcPFdtovnGOFf=d+3g@mail.gmail.com>
 <alpine.LFD.2.11.1503241125450.27567@knanqh.ubzr>
 <CAKv+Gu9pNZFjrRbRkK=Yp5RkV6GCM2NmVWzXRYmqmS97q+e0NQ@mail.gmail.com>
 <20150324232552.GW8656@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu9Br2mDLW+X3TkZsoTxWAtGqdK8u2R3HsGjcAKR21pypw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 March 2015 at 00:25, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Mar 24, 2015 at 04:51:07PM +0100, Ard Biesheuvel wrote:
>> Yes, there are still some instances left of that, including the core
>> cpu_resume() itself.
>> (and they all copy the same comment :-))
>
> That's because I follow the ethos of "why write complex code when
> simple and obvious code will do" and we'd done this for the original
> SA11x0 CPU resume code which formed (to some extent) the basis of the
> consolidated version we have today.
>
> At the time cpu_resume() was consolidated (which is actually only in
> the last five years or so) there wasn't the requirement to have large
> kernels link, so rewriting it as relatively complex implementation
> would've been damned stupid and a needless change in the consolidation
> effort.
>

Oh I totally agree. The simplest code that does the job correctly
should be preferred in almost all cases. But some of the copies are
rather shallow, e.g., the s5pv210 code sits in .data, but does nothing
except branch to cpu_resume(). Here the pattern is copied for no
obvious reason.
