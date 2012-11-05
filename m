From: stano@meduna.org (Stanislav Meduna)
Date: Mon, 05 Nov 2012 10:14:24 +0100
Subject: scheduler clock for MXS [Was: Re: Wakeup latency measured with
 SCHED_TRACER depends on HZ]
In-Reply-To: <20121105025753.GA26528@S2100-06.ap.freescale.net>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
Message-ID: <50978370.9060001@meduna.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2012 03:57, Shawn Guo wrote:

>> The patch in attach fixes this. I can only test the MX28 part -
>> I don't have any timrot_is_v1() (MX23) hardware and I don't
>> know whether a source that wraps after ~2 seconds is OK at all.
> 
> From my quick testing on imx23 with printk timestamp, it's not OK,
> so we may need to leave imx23 out there.

Hmm, does it wrap after 2 seconds? From my grepping and googling
the code should now adapt itself, the hardcoded limit is gone...
What does the dmesg line such as

  sched_clock: 32 bits at 32kHz, resolution 31250ns,
    wraps every 134217727ms

output on that hardware?

Thanks for the comments, I will resubmit the corrected patch after
waiting ~1,5 days to verify correct wrapping with MX28.

Regards
-- 
                                         Stano
