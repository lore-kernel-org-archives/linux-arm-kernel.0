From: eric@anholt.net (Eric Anholt)
Date: Sat, 25 Jun 2016 20:10:18 -0700
Subject: [PATCH V2 13/63] clocksource/drivers/bcm2835_timer: Convert init
 function to return error
In-Reply-To: <1466112442-31105-14-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-14-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <87mvm8myqt.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> The init functions do not return any error. They behave as the following:
>
>  - panic, thus leading to a kernel crash while another timer may work and
>    make the system boot up correctly
>
>  or
>
>  - print an error and let the caller unaware if the state of the system
>
> Change that by converting the init functions to return an error conforming
> to the CLOCKSOURCE_OF_RET prototype.
>
> Proper error handling (rollback, errno value) will be changed later case
> by case, thus this change just return back an error or success in the init
> function.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

For the bcm2835 changes here and in 63/63:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160625/06972f9a/attachment.sig>
