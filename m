From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 11 Apr 2013 07:20:59 -0700
Subject: [RESEND PATCH] PM / Runtime: Idle devices asynchronously after
 probe|release
In-Reply-To: <1365606048-27603-1-git-send-email-ulf.hansson@stericsson.com>
 (Ulf Hansson's message of "Wed, 10 Apr 2013 17:00:48 +0200")
References: <1365606048-27603-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <87txndxi5w.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@stericsson.com> writes:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Putting devices into idle|suspend in a synchronous manner means we are
> waiting for each device to become idle|suspended before the probe|release
> is fully done.
>
> This patch switch to use the asynchronous runtime PM API:s instead and
> thus improves the parallelism since we can move on and handle the next
> device in queue in an earlier phase.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Kevin Hilman <khilman@linaro.org>
