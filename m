From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 10 Nov 2013 10:52:52 +0100
Subject: [PATCH 2/2] clocksource: sun4i: change CPU mask to
 cpu_possible_mask
In-Reply-To: <527B693D.9010304@linaro.org>
References: <1382699771-4396-1-git-send-email-maxime.ripard@free-electrons.com>
 <1382699771-4396-3-git-send-email-maxime.ripard@free-electrons.com>
 <527B693D.9010304@linaro.org>
Message-ID: <20131110095252.GH26440@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thu, Nov 07, 2013 at 11:19:41AM +0100, Daniel Lezcano wrote:
> On 10/25/2013 01:16 PM, Maxime Ripard wrote:
> >The interrupt for the timer is a shared processor interrupt, so any CPU
> >found in the system can handle it. Switch to our cpumask to
> >cpu_possible_mask instead of cpumask_of(0).
> >
> >Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Applied to my tree for 3.14

Thanks!

> sidenote: did you look at the CLOCK_EVT_FEAT_DYNIRQ flag ? It may
> reduce the number of wakeup for your system.

Not yet, but I'll give it a look for sure :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131110/94b10b95/attachment.sig>
