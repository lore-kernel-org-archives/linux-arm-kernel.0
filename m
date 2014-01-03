From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 3 Jan 2014 06:13:53 +0000
Subject: [RFC] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <87eh58zh2u.fsf@nbsps.com>
References: <1385979309-10505-1-git-send-email-Li.Xiubo@freescale.com>,
 <87eh58zh2u.fsf@nbsps.com>
Message-ID: <7e22211a84ee48bbbfc3d7d286b9f766@BLUPR03MB504.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> That is instead of modifying the low level accessor, you can alter the
> driver masks based on the OF selected endian.  Many of the registers are
> already accessed as run-time fields because each channel is in a
> different bit position.  There are only two registers with fields that
> cross a byte boundary; COUNT and MOD.  These two must be swapped.  The
> others are either a byte or are accessed base on a channel number.
> 
> For example in fsl_pwm_set_polarity(), we would read the memory, swap
> the value, calculate a bit to set, clear or set the bit and then write
> back the swapped value all on the 'big_endian' condition.  This way, you
> just read a bit shift which is conditional on the endian at probe time
> and don't double swap.
> 
> In the fsl_counter_clock_enable(), the example is using 'write ignored
> bits' and duplicating the value in both big/little bytes.  An
> alternative is to parameterize all the mask/values in 'const struct' and
> have a different pointer for big/little and store this in-place (or via
> a pointer) in fsl_pwm_chip.
> 

Bill, I have implemented one version using the method above, and will send
the RFC patch, could you help me review it ?

Thanks,

--
Best Regards,
Xiubo
