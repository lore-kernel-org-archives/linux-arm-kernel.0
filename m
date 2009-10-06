From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Tue, 6 Oct 2009 18:38:26 +0400
Subject: [PATCH] SA1100: fix building of h3100
In-Reply-To: <20091006112831.GA15695@n2100.arm.linux.org.uk>
References: <1254765034-29849-1-git-send-email-mad_soft@inbox.ru>
	<20091006125318.d430a642.kristoffer.ericson@gmail.com>
	<20091006112831.GA15695@n2100.arm.linux.org.uk>
Message-ID: <20091006143826.GB3511@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:28 Tue 06 Oct     , Russell King - ARM Linux wrote:
> If there are people seriously looking at H3[16]00 stuff, it would be
> a good idea to move it over to use the proper GPIO support rather
> than continue to rely upon its own version.

Yes, that's that I'm working on - the plan is to get rid of those horrible
abstracted ipaq egpios, and use gpiolib functions instead (reusing
htc-egpio driver for gpio expander)

I'll try to finish and clean up my patches soon, and submit them for
review, so hopefully they could get into 2.6.33

> Also maybe splitting it into h3100.c and h3600.c, with (if any) common
> bits in h3xxx.c might be an idea?

Yes, as I said, that's the direction I'd like to go too.
After conversion to gpiolib and real gpios there probably will left
not much common at all.

-- 
Best regards,
Dmitry "MAD" Artamonow
