From: robherring2@gmail.com (Rob Herring)
Date: Fri, 10 Jan 2014 14:04:57 -0600
Subject: [PATCH v3 4/6] arm: add early_ioremap support
In-Reply-To: <20140110165847.GG925@arm.com>
References: <1389325833-16535-1-git-send-email-msalter@redhat.com>
 <1389325833-16535-5-git-send-email-msalter@redhat.com>
 <CAL_JsqLZQ=3gph4yaNSrZ5oPL3kasQKqA5C5+my0GwjGHsvMeQ@mail.gmail.com>
 <20140110165847.GG925@arm.com>
Message-ID: <CAL_JsqK-UppOnncr19dPEX8d8m0dvnONo_bzaXYX78rc2LfjwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 10:58 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Fri, Jan 10, 2014 at 04:11:03PM +0000, Rob Herring wrote:
>> On Thu, Jan 9, 2014 at 9:50 PM, Mark Salter <msalter@redhat.com> wrote:
>> > This patch uses the generic early_ioremap code to implement
>> > early_ioremap for ARM. The ARM-specific bits come mostly from
>> > an earlier patch from Leif Lindholm <leif.lindholm@linaro.org>
>> > here:
>> >
>> >   https://lkml.org/lkml/2013/10/3/279
>>
>> I think this will be useful to implement an arm64 style earlycon for
>> arm as the current DEBUG_LL doesn't really work with multi-platform
>> kernels. I started on this and quickly realized I needed the fixmap
>> support.
>
> It would be even better if you can make it more generic
> (drivers/tty/serial/) and keep DEBUG_LL as a specialised case for
> arch/arm (when !multi-platform).

Y
