From: jamie.iles@picochip.com (Jamie Iles)
Date: Wed, 1 Sep 2010 13:57:32 +0100
Subject: [PATCH] ARM: perf: fix event validation
In-Reply-To: <1283343082-28764-1-git-send-email-will.deacon@arm.com>
References: <1283343082-28764-1-git-send-email-will.deacon@arm.com>
Message-ID: <20100901125732.GA28196@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 01:11:22PM +0100, Will Deacon wrote:
> The validate_event function in the ARM perf events backend has the
> following problems:
> 
> 1.) Events that are disabled count towards the cost.
> 2.) Events associated with other PMUs [for example, software events or
>     breakpoints] do not count towards the cost, but do fail validation,
>     causing the group to fail.
> 
> This patch changes validate_event so that it ignores events in the
> PERF_EVENT_STATE_OFF state or that are scheduled for other PMUs.
> 
> Cc: Jamie Iles <jamie.iles@picochip.com>
> Reported-by: Pawel Moll <pawel.moll@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Resend with correct spelling of Pawel's email address on CC.
> Jamie - are you ok with this fix?
Yes, looks good to me.

Acked-by: Jamie Iles <jamie.iles@picochip.com>
