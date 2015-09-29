From: robh@kernel.org (Rob Herring)
Date: Tue, 29 Sep 2015 11:58:47 -0500
Subject: [PATCH v6 20/22] driver core: Allow deferring probes until late
 init
In-Reply-To: <CAAObsKBoBgP_y161qWC_U+yVtbWxudFgBNM7map0jz2WcJws_w@mail.gmail.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-21-git-send-email-tomeu.vizoso@collabora.com>
 <5606E0DA.2040900@kernel.org>
 <CAAObsKBoBgP_y161qWC_U+yVtbWxudFgBNM7map0jz2WcJws_w@mail.gmail.com>
Message-ID: <CAL_JsqL+ZhS7ob6Z7ZPRScAjMBTP4hABe_vh4jPjstKAbScGDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 3:05 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> On 26 September 2015 at 20:15, Rob Herring <robh@kernel.org> wrote:
>> On 09/21/2015 09:03 AM, Tomeu Vizoso wrote:
>>> Add a field to struct device that instructs the device-driver core to
>>> defer the probe of this device until the late_initcall level.
>>
>> This is true until the next patch with moves deferred probe processing
>> to device_initcall_sync. So disabling this option alone won't totally
>> revert to current behaviour. I guess patch 21 could be reverted if
>> necessary.
>
> Actually, the goal with that commit was to prevent potential problems
> due to the increased pressure on late_initcall, as suggested by
> Grygorii Strashko, but I haven't found yet any evidence of it being
> needed, and in my testing the series boot all boards in kernelci with
> or without this commit. So I would just not commit it for now and only
> consider applying it later if someone reports a problem.

I had similar concerns with assumptions about ordering WRT
late_initcall. I would keep this for now.

Rob
