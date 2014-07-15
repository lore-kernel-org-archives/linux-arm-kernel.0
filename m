From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Tue, 15 Jul 2014 10:04:00 +0530
Subject: [PATCH v2] ARM: dts: Add mask-tpm-reset to the device tree
In-Reply-To: <CAD=FV=UQfQpJ3Tp-cBAfPsH9wHXb1yknget6iMQcgOVnH1PwFA@mail.gmail.com>
References: <1405319602-29892-1-git-send-email-vikas.sajjan@samsung.com>
 <CAD=FV=UQfQpJ3Tp-cBAfPsH9wHXb1yknget6iMQcgOVnH1PwFA@mail.gmail.com>
Message-ID: <CAGm_ybhE62Hjn6H5CJTMG92ZtFdx5wugyprjwLdidHoh6f9wBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug,

On Mon, Jul 14, 2014 at 10:30 PM, Doug Anderson <dianders@chromium.org> wrote:
> Vikas,
>
> On Sun, Jul 13, 2014 at 11:33 PM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>> From: Doug Anderson <dianders@chromium.org>
>>
>> The mask-tpm-reset GPIO is used by the kernel to prevent the TPM from
>> being reset across sleep/wake.  If we don't set it to anything then
>> the TPM will be reset.  U-Boot will detect this as invalid
>> and will reset the system on resume time. This GPIO can always be low
>> and not hurt anything.  It will get pulled back high again during a
>> normal warm reset when it will default back to an input.
>>
>> To properly preserve the TPM state across suspend/resume and to make
>> the chrome U-Boot happy, properly set the GPIO to mask the
>> reset to the TPM.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>> ---
>> changes since v1:
>>         - removed fixed regulator and used hogs instead.
>>
>>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>
> This looks reasonable to me except for two things:
>
> 1. You need to apply this to pit and pi (not just pi)
>
> 2. The proper sort ordering for elements within a pin control group is
> by pin number, so this pin should be _after_ gpx0-2, not before.


Sure, will repost both pit and pi by reordering the pin as you suggested.
