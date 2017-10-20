From: willemdebruijn.kernel@gmail.com (Willem de Bruijn)
Date: Fri, 20 Oct 2017 11:39:35 -0400
Subject: v4.14-rc3/arm64 DABT exception in atomic_inc() / __skb_clone()
In-Reply-To: <CACT4Y+bjzzCv3LSxK12C1xB8GfR3UYCrX_5phRYJ8fpxh9vcvQ@mail.gmail.com>
References: <EAA60182-6F08-412E-8F8B-FD4B0309A858@gmail.com>
 <20171020111408.edj24tztxdptte5r@lakrids.cambridge.arm.com>
 <960D71EC-C1E9-4898-ACBE-543FC09483FF@gmail.com>
 <CACT4Y+bjzzCv3LSxK12C1xB8GfR3UYCrX_5phRYJ8fpxh9vcvQ@mail.gmail.com>
Message-ID: <CAF=yD-K76TMjHiYRTRAnxM-x4LBcUDY+27WX477HW6kG=L_aZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 11:14 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Oct 20, 2017 at 4:40 PM, Wei Wei <dotweiba@gmail.com> wrote:
>> Sadly, the syzkaller characterized it as a non-reproducible bug and there were empty
>>  repro files. But if manually executing in VM like this ?./syz-execprog -executor=
>> ./syz-executor -repeat=0 -procs=16 -cover=0 crash-log?, it crashed when executing exactly
>> program 1056 using log0 provided.
>>
>> I failed to generate the C reproducer with syz-repro as it said ?no target compiler?
>> in the final step. I would appreciate if you could give some hints.
>
> syzkaller tries to use aarch64-linux-gnu-gcc when cross-compiling to arm64:
> https://github.com/google/syzkaller/blob/master/sys/targets/targets.go#L62
> Try to install g++-aarch64-linux-gnu.
> Or how should it be done on your system?

A core dump would also be helpful to root around in and inspect
what those registers point to. Thanks for posting the various reports
on github, btw.
