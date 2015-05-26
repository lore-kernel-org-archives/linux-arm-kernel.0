From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 26 May 2015 15:50:12 +0200
Subject: [PATCH] input: ambakmi: Fix system PM by converting to modern
 callbacks
In-Reply-To: <20150522143933.GI2067@n2100.arm.linux.org.uk>
References: <1429008108-29295-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFrhC1MCmOfoweztNtzk-Spwhj1uj7-sz3UtJhT_bHDQ+g@mail.gmail.com>
 <20150522143933.GI2067@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFpbTx5rRuewziGzsqSHp1z7PO2-9VWV6DUTDytnWwUbpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 May 2015 at 16:39, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, May 22, 2015 at 04:37:12PM +0200, Ulf Hansson wrote:
>> On 14 April 2015 at 12:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> > The legacy system PM support has long time ago been dropped from the
>> > AMBA bus. Align to that by converting to the modern system PM
>> > callbacks.
>> >
>> > Fixes: 26825cfd90f9 (ARM: 7914/1: amba: Drop legacy PM support ...)
>> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> What happened with this one? Can we queue it for 4.2?
>
> Why does it have a Fixes: tag?  Is it fixing a real bug, or is it just
> fixing a warning that the kernel prints?

I would expect it to fix a real bug, but I am not able to test this on HW.

Since the commit 26825cfd90f9, the amba bus doesn't invoke the legacy
system PM callbacks any more. Instead it uses pm_generic_resume() as
its ->resume() callback which means amba_kmi_resume() won't be invoked
during system PM resume.

Kind regards
Uffe
