From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Mar 2018 16:37:14 +0000
Subject: [PATCH v2 3/3] arm64: signal: Ensure si_code is valid for all
 fault signals
In-Reply-To: <1519926248-12591-4-git-send-email-Dave.Martin@arm.com>
References: <1519926248-12591-1-git-send-email-Dave.Martin@arm.com>
 <1519926248-12591-4-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180308163713.GD9573@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Thu, Mar 01, 2018 at 05:44:08PM +0000, Dave Martin wrote:
> Currently, as reported by Eric, an invalid si_code value 0 is
> passed in many signals delivered to userspace in response to faults
> and other kernel errors.  Typically 0 is passed when the fault is
> insufficiently diagnosable or when there does not appear to be any
> sensible alternative value to choose.

This looks good to me. Please could you rebase it on top of for-next/core,
so that I can apply it for 4.17? The other two patches in the series need
an Ack for the core changes, so it would be worth dealing with those
separately imo.

Cheers,

Will
