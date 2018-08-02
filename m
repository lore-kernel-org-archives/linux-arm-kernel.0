From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 2 Aug 2018 13:39:37 +0100
Subject: [PATCH 3/3] clockevents: warn if cpu_all_mask is used for cpumask
 while registering new device
In-Reply-To: <1531308264-24220-3-git-send-email-sudeep.holla@arm.com>
References: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
 <1531308264-24220-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <988e86c6-92bb-b73d-068b-04dfbc0fffda@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 11/07/18 12:24, Sudeep Holla wrote:
> Using cpu_all_mask in clockevents cpumask may result in issues while
> comparing multiple clockevent devices to choose the preferred one.
> On one of the platforms with 2 system(i.e. non per-CPU) timers with
> different ratings, having cpu_all_mask for one of the device resulted
> in boot hang with forever loop in clockevents_notify_released as both
> were being selected as preferred.
> 
> In order to prevent such issues in future, let's warn if any clockevent
> drivers sets cpu_all_mask as it's cpumask and just override it to use
> cpu_possible_mask. All the existing occurrences of cpu_all_mask are
> already replaced with cpu_possible_mask.
> 

Daniel has picked up patch 1/3, do you want me to resend this patch 2
and 3 again or you happy to pick them ?

-- 
Regards,
Sudeep
