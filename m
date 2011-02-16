From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 16 Feb 2011 14:07:28 +0100
Subject: [PATCH 0/3] OMAP2+ hwmod fixes
In-Reply-To: <1297858285-7056-1-git-send-email-rnayak@ti.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com>
Message-ID: <4D5BCC10.2060301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra,

On 2/16/2011 1:11 PM, Nayak, Rajendra wrote:
> This series fixes some hwmod api return values
> and also adds some state checks.
> The hwmod iterator functions are made to
> continue and not break if one of the
> callback functions ends up with an error.

By doing that, you change the behavior of this function.
I'm not sure I fully understand why.
Could you elaborate on the use case?

To avoid that behavior in the past, I was just returning
0 in case of failure to avoid stopping the iteration.
It looks like you do not want to stop the iteration but still
retrieve the error.
I do not see in this series what you plan to do with the
error at the end of the iteration.

Thanks,
Benoit
