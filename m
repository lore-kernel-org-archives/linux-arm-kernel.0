From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 7 May 2015 08:17:19 -0700
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
In-Reply-To: <55440EDA.4030905@codeaurora.org>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
 <1981330.kGUrTurMy5@diego> <5543E79F.2080400@codeaurora.org>
 <22709390.NTAlubMgNB@diego> <55440EDA.4030905@codeaurora.org>
Message-ID: <CAMAWPa_n+59+v+x3fKkmdtW1wMJF7kqtTjLLowmv1xwGWprYJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 1, 2015 at 4:40 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 05/01/15 15:07, Heiko St?bner wrote:
>> Am Freitag, 1. Mai 2015, 13:52:47 schrieb Stephen Boyd:
>>
>>>> Instead I guess we could hook it less deep into clk_get_sys, like in the
>>>> following patch?
>>> It looks like it will work at least, but still I'd prefer to keep the
>>> orphan check contained to clk.c. How about this compile tested only patch?
>> I gave this a spin on my rk3288-firefly board. It still boots, the clock tree
>> looks the same and it also still defers nicely in the scenario I needed it
>> for. The implementation also looks nice - and of course much more compact than
>> my check in two places :-) . I don't know if you want to put this as follow-up
>> on top or fold it into the original orphan-check, so in any case
>>
>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
> Thanks. I'm leaning towards tossing your patch 2/2 and replacing it with
> my patch and a note that it's based on an earlier patch from you.

It appears this has landed in linux-next in the form of 882667c1fcf1
clk: prevent orphan clocks from being used.  A bunch of boot failures
for sunxi in today's linux-next[1] were bisected down to that patch.

I confirmed that reverting that commit on top of next/master gets
sunxi booting again.

Kevin

[1] http://kernelci.org/boot/all/job/next/kernel/next-20150507/
