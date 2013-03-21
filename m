From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Mar 2013 11:13:17 -0700
Subject: [PATCHv3 01/10] clocksource: add generic dummy timer driver
In-Reply-To: <20130321180922.GB10716@e106331-lin.cambridge.arm.com>
References: <1363198676-30417-1-git-send-email-sboyd@codeaurora.org>
 <1363198676-30417-2-git-send-email-sboyd@codeaurora.org>
 <20130321180922.GB10716@e106331-lin.cambridge.arm.com>
Message-ID: <514B4DBD.4060403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/13 11:09, Mark Rutland wrote:
> Hi Stephen,
>
> I've just been trying to test the dummy timer, and realised it's broken, as it
> registers a cpu notifier from a device_initcall (after SMP's been brought up),
> and doesn't ensure all active CPUs have been set up. Evidently no-one else has
> attempted to test it thus far, and I'm not able to throughly test it at the
> moment.

Would it be sufficient to register as a pre-smp initcall?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
