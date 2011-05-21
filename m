From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 21 May 2011 22:39:46 +0400
Subject: [PATCH] mioa701: move gpio-pullup functionality to gpio-vbus
In-Reply-To: <4DD6A6B1.9010209@free.fr>
References: <1305719866-9811-1-git-send-email-dbaryshkov@gmail.com>
	<4DD6A6B1.9010209@free.fr>
Message-ID: <BANLkTikJE4gRY=Si5Z1i939j0_B41AWARQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/20/11, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> On 05/18/2011 01:57 PM, Dmitry Eremin-Solenikov wrote:
>> gpio-vbus can (and should?) handle D+ pullup gpio for us. Move gpio-pullup
>> handling
>> to gpio-vbus and stop providing udc_info as it's empty now.
> No sorry, NAK.
>
> As a matter of fact, even if gpio-vbus driver handles correctly the VBUS
> sensing and D+ line powering, it still lacks the suspend / resume
> handling to "disconnect the D+ line" on suspend and reconnect it on
> "resume". That's the reason I nack this patch, as for me, gpio-vbus and
> pxa27x-udc are not yet iso functional.

gpio-vbus handles D+ line. It doesn't handle suspend.
BTW: do you mean system suspend (via pm->suspend), or USB suspend (via
USB SUSPEND interrupt)

> If I was provided proof that this is innoccuous (ie. there is no power
> draw possible in suspend, or that the resume procedure still works with
> gpio-vbus), then I'll ack the patch.

Hmm. I'll think about suspend issue (if you give me more info), but only you
can test the resume. Could you please test it?

-- 
With best wishes
Dmitry
