From: jean.pihet@linaro.org (Jean Pihet)
Date: Tue, 24 Sep 2013 14:03:47 +0200
Subject: [PATCH 3/4] perf tools: Check libunwind for availability of dwarf
 parsing feature
In-Reply-To: <20130924100620.GG15119@mudshark.cambridge.arm.com>
References: <1379323053-11458-1-git-send-email-jean.pihet@linaro.org>
 <1379323053-11458-4-git-send-email-jean.pihet@linaro.org>
 <20130917102904.GA27258@mudshark.cambridge.arm.com>
 <CAFrcx1nnx0+kWx3z3A86Fwz13RYRVSPSG0YHBcxFeFQP8W7jBg@mail.gmail.com>
 <20130924093450.GB1008@krava.brq.redhat.com>
 <20130924100620.GG15119@mudshark.cambridge.arm.com>
Message-ID: <CAFrcx1k-sfHMRz6mvibBbph4vNOMkVddE4LEE4yXbWHC3DwMZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiri, Will,

On 24 September 2013 12:06, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Sep 24, 2013 at 10:34:50AM +0100, Jiri Olsa wrote:
>> On Tue, Sep 24, 2013 at 10:55:32AM +0200, Jean Pihet wrote:
>> > Ping on the series. The two patches above (3/4 and 4/4) are generic
>> > while the two others are impacting ARM only.
>> > Is it possible to get an Ack for the generic ones?
>>
>> I'm fine with those changes.. still I'm sort of worried about
>> current DWARF unwind users (but not sure if there're any),
>> who depends on packaged libunwind compiled without
>> --enable-debug-frame option.
>
> Since x86 is the only architecture using libunwind with perf at the moment,
> and I'd expect it to use .eh_frame for unwinding, I'm also not sure there
> are any existing users to worry about.
Right

>
>> I've seen your libunwind patch to make it default, but
>> not sure if it was accepted.. if not, maybe we should
>> detect this and build that code conditionaly.
>
> It certainly defaults to "on" for ARM, but other architectures have to
> enable it explicitly afaict.
Yes that is correct.
This patch (3/4) detects if the debug frame code is enabled in
libunwind and uses the lib only if it is the case.
Users that want the feature have to enable it explicitly; the commit
description documents how to do that.

So I think we are safe here.

>
> Will

Thanks,
Jean
