From: swetland@google.com (Brian Swetland)
Date: Wed, 10 Nov 2010 10:34:25 -0800
Subject: [PATCH v3] msm: smd: Reduce driver log chatter
In-Reply-To: <1289413457.15905.95.camel@Joe-Laptop>
References: <1289349036-16941-1-git-send-email-davidb@codeaurora.org>
	<1289411969-24650-1-git-send-email-davidb@codeaurora.org>
	<1289413457.15905.95.camel@Joe-Laptop>
Message-ID: <AANLkTi=fBhqvo+xuAMPdkiO0z+K-R5vfS6+P8cf=Yws5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At this point, I think we could just drop the printk()s on the init
functions.  They date back from when we first brought up the driver
and I'm not sure they're of much value at all any more.

Brian

On Wed, Nov 10, 2010 at 10:24 AM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2010-11-10 at 09:59 -0800, David Brown wrote:
>> ?arch/arm/mach-msm/smd.c | ? 18 ++++++++++--------
>
> Hi again David. ?More trivia. Ignore at your pleasure.
>
>> ?1 files changed, 10 insertions(+), 8 deletions(-)
>> diff --git a/arch/arm/mach-msm/smd.c b/arch/arm/mach-msm/smd.c
>
> A moderately common kernel style uses macros like:
>
> #define FUNC_ENTER() ? ?pr_debug("--> %s\n", __func__);
> #define FUNC_EXIT() ? ? pr_debug("<-- %s\n", __func__);
> or
> #define FUNC_ENTER() ? ?pr_debug("Enter %s\n", __func__);
> #define FUNC_EXIT() ? ? pr_debug("Exit ?%s\n", __func__);
>
> The macro names vary.
> I've seen enter, _enter, kenter, func_enter, etc.
>
>> @@ -939,7 +941,7 @@ int smsm_set_sleep_duration(uint32_t delay)
>> ?int smd_core_init(void)
>> ?{
>> ? ? ? int r;
>> - ? ? pr_info("smd_core_init()\n");
>> + ? ? pr_debug("smd_core_init()\n");
>
> ? ? ? ?FUNC_ENTER();
>
>> @@ -992,14 +994,14 @@ int smd_core_init(void)
>> ? ? ? smsm_change_state(SMSM_STATE_APPS_DEM, ~0, 0);
>> ?#endif
>>
>> - ? ? pr_info("smd_core_init() done\n");
>> + ? ? pr_debug("smd_core_init() done\n");
>
> ? ? ? ?FUNC_EXIT();
>
>> ?static int __devinit msm_smd_probe(struct platform_device *pdev)
>> ?{
>> - ? ? pr_info("smd_init()\n");
>> + ? ? pr_debug("smd_init()\n");
>
> wrong function name? FUNC_ENTER();
>
>
