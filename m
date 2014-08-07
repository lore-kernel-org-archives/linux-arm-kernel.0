From: jcmvbkbc@gmail.com (Max Filippov)
Date: Thu, 7 Aug 2014 19:42:59 +0400
Subject: [PATCH 1/7] arm: use generic fixmap.h
In-Reply-To: <alpine.LFD.2.11.1408071131170.6061@knanqh.ubzr>
References: <1407353564-21478-1-git-send-email-keescook@chromium.org>
 <1407353564-21478-2-git-send-email-keescook@chromium.org>
 <CAMo8Bf+uq1vhqb7KxnNFHTZ53C1mtw_Do6dn09j7jjw_7MWF_Q@mail.gmail.com>
 <CAL_JsqJgRFYTfdsY48C9QreBH=VcM3t-9AzFSV8oXLB5tVGjUw@mail.gmail.com>
 <alpine.LFD.2.11.1408071131170.6061@knanqh.ubzr>
Message-ID: <CAMo8Bf+DP-xZGnnFFvwc1XDEGUGkj1KkYQ_x+2i_hE0a9t7NKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 7, 2014 at 7:32 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 7 Aug 2014, Rob Herring wrote:
>
>> On Thu, Aug 7, 2014 at 10:15 AM, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> > Hi,
>> >
>> > On Wed, Aug 6, 2014 at 11:32 PM, Kees Cook <keescook@chromium.org> wrote:
>> >> ARM is different from other architectures in that fixmap pages are indexed
>> >> with a positive offset from FIXADDR_START.  Other architectures index with
>> >> a negative offset from FIXADDR_TOP.  In order to use the generic fixmap.h
>> >
>> > Does anybody know if there's any reason why generic fixmap.h uses negative
>> > offsets? It complicates things with no obvious benefit if you e.g. try to align
>> > virtual address in the fixmap region with physical page color (that's why I've
>> > switched xtensa to positive fixmap addressing in v3.17).
>>
>> No, but each arch doing it differently is even more annoying.
>
> Why not switching everybody to positive offsets then?

I can cook a patch if people agree that that'd be good.

-- 
Thanks.
-- Max
