From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Thu, 31 Mar 2016 10:34:15 +0800
Subject: [Query]set clk rate must operate its coordinated clock
In-Reply-To: <20160311165152.4103.82090@quark.deferred.io>
References: <20160309152420.20de187a@xhacker>
 <20160311165152.4103.82090@quark.deferred.io>
Message-ID: <CALx668WqPF12eD=f3mfd-=TYwVe4bVk0YVoKtGV_XPM8c+_FeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+linux-mediatek list

On Sat, Mar 12, 2016 at 12:51 AM, Michael Turquette
<mturquette@baylibre.com> wrote:
> Jisheng,
>
> Quoting Jisheng Zhang (2016-03-08 23:24:20)
>> Dear Stephen, Michael, Sebastian and all,
>>
>> I have the following clk case which I dunno the elegant solution:
>>
>>
>> cpuclk have two parents: cpupll and refclk. When set the cpuclk freq, we
>> have to set its parent's freq, I.E cpupll freq. But before changing the
>> cpupll's freq, we should set its refclk as its parent firstly.
>>
>> AFAIK, this is a common case, I have seen such requirement in rockchip, samsung
>> clk driver. They solve this by notifier, but as pointed out by Michael
>> in http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/351565.html
>>
>> "This is also a hack and it points towards some missing infrastructure in the
>> clock framework."
>>
>> I also don't like the notifier solution, I believe the elegant solution could
>> be using the coordinated clock infrastructure. So what's the status of
>> this infrastructure? I can test, and I can even add some code to make it be
>> ready to be merged if you guide me ;)
>
> Thanks for the email. I hope to finish that feature before ELC. I have
> Cc'd Pi-Cheng Chen from Mediatek who is also interested in coordinated
> clock rates.

Hi Mike,

Sorry for my late response.
Glad to hear that you're still working on it.
I am ready to test it on Mediatek platform.
Looking forwards to the new clk feature.

Thanks,
Pi-Cheng

>
> Regards,
> Mike
>
>>
>> Thanks in advance,
>> Jisheng
