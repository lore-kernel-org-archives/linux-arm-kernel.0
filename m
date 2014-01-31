From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 31 Jan 2014 11:19:21 +0100
Subject: [PATCH v2 09/21] pinctrl: mvebu: dove: provide generic mpp
 callbacks
In-Reply-To: <CACRpkdYpGm-KAFqU5cpzbhrM1NaZJYtQa86wP7qJFrai2bDYbw@mail.gmail.com>
References: <1390674856-4993-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390869573-27624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390869573-27624-10-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdYpGm-KAFqU5cpzbhrM1NaZJYtQa86wP7qJFrai2bDYbw@mail.gmail.com>
Message-ID: <52EB78A9.4020306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/14 11:13, Linus Walleij wrote:
> On Tue, Jan 28, 2014 at 1:39 AM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
>
>> We want to get rid of passing register addresses to common pinctrl
>> driver, so provide set/get callbacks for generic mpp pins.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
[...]
>> @@ -374,7 +398,7 @@ static struct mvebu_mpp_ctrl dove_mpp_controls[] = {
>>          MPP_FUNC_CTRL(13, 13, "mpp13", dove_pmu_mpp_ctrl),
>>          MPP_FUNC_CTRL(14, 14, "mpp14", dove_pmu_mpp_ctrl),
>>          MPP_FUNC_CTRL(15, 15, "mpp15", dove_pmu_mpp_ctrl),
>> -       MPP_REG_CTRL(16, 23),
>> +       MPP_FUNC_CTRL(16, 23, NULL, dove_mpp_ctrl),
>
> What does this have to do with the rest of the patch?
>
> (Maybe I'm stupid, beware I'm just glancing over this stuff as I
> see the patch set is still in development.)

Not really, the driver is slightly misdesigned and this patches
try to clean this up a bit. I have prepared a v3 branch for the
MVEBU guys to have a look at first.

Short version: Thanks for trying to review this, but I guess your time
would be better spent on a soon to be posted v3.

Long version:
Not having a callback identifies each control as "generic mpp pins",
so by passing a callback we make them "SoC specific" as a preparation
to remove the common "generic mpp" set/get function.

Sebastian
