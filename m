From: stanleymiao@gmail.com (Stanley.Miao)
Date: Tue, 19 Oct 2010 10:25:50 +0800
Subject: [PATCH 2/3] Add hardware timer support for Mindspeed Comcerto
	platflorm
In-Reply-To: <20101018212433.GD20376@n2100.arm.linux.org.uk>
References: <1287045489-1133-1-git-send-email-stanleymiao@gmail.com>
	<1287045489-1133-2-git-send-email-stanleymiao@gmail.com>
	<1287045489-1133-3-git-send-email-stanleymiao@gmail.com>
	<20101018212433.GD20376@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=K35dNFWzD9+AppgCcTG5Xct+DRV7ezCCYEs_4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell,

Thanks for your review. I will update them and send V2.

Stanley.

2010/10/19 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Oct 14, 2010 at 04:38:08PM +0800, stanleymiao at gmail.com wrote:
<snip>
>> + ? ? if (status & t->mask) {
>> + ? ? ? ? ? ? /* we need to disable interrupt to simulate ONESHOT mode,
>> + ? ? ? ? ? ? ?* do it before clearing the interrupt to avoid race */
>> + ? ? ? ? ? ? if (dev->mode != CLOCK_EVT_MODE_PERIODIC)
>> + ? ? ? ? ? ? ? ? ? ? gptimer_disable(t);
>
> Err, the one-shot mode emulation support looks buggy and completely
> unnecessary. ?Generally with clockevents, you tell it what the hardware
> supports and clockevents deals with it. ?You shouldn't emulate modes
> that the hardware doesn't support - especially if you're going to ignore
> the 'cycles' from set_next_event().
>
