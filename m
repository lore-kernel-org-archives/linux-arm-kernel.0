From: liuj97@gmail.com (Jiang Liu)
Date: Tue, 15 Oct 2013 00:01:20 +0800
Subject: [RFT PATCH v2 3/4] arm64: reduce duplicated code when
 saving/restoring FPSIMD for signal handling
In-Reply-To: <20131014154401.GG7682@arm.com>
References: <1381674029-430-1-git-send-email-liuj97@gmail.com>
 <1381674029-430-3-git-send-email-liuj97@gmail.com>
 <20131014154401.GG7682@arm.com>
Message-ID: <525C1550.5090208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2013 11:44 PM, Catalin Marinas wrote:
> On Sun, Oct 13, 2013 at 03:20:19PM +0100, Jiang Liu wrote:
>> +void fpsimd_prepare_sigctx(struct fpsimd_state *state)
>> +{
>> +	/* dump the hardware registers to the fpsimd_state structure */
>> +	fpsimd_save_state(state);
>> +	fpsimd_clear_fpsr();
>> +}
> 
> What don't particularly like is that you save the FP context and then
> corrupt it. Can we get preempted after this function and before we save
> it on the signal stack?
> 
Yeah, good point!
There's a race window to get preempted, will fix it.
Thanks!
Gerry
