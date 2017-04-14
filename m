From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 14 Apr 2017 12:07:05 +0200
Subject: [PATCH] ARM: dts: at91: use correct compatible for the gpio mux
 controller
In-Reply-To: <1492118578-15356-1-git-send-email-peda@axentia.se>
References: <1492118578-15356-1-git-send-email-peda@axentia.se>
Message-ID: <20170414100705.tiltc433lidqzcr2@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/2017 at 23:22:58 +0200, Peter Rosin wrote:
> The compatible string for a gpio based mux controller is "gpio-mux",
> and nothing else.
> 
> Fixes: 29dd89418007 ("ARM: dts: at91: add envelope detector mux to the Axentia TSE-850")
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  arch/arm/boot/dts/at91-tse850-3.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi!
> 
> The compatible string for the gpio based mux changed along the way (on
> request from Rob) but I failed to update the implementation in the
> gpio-mux driver when I made that change. Consequently, I didn't notice
> that I didn't update the compatible string here either, since it all
> continued to work in my tests...
> 
> The compatible string in the gpio-mux driver is being fixed to match
> documentation, so this of course needs fixing too. No TSE-850 devices
> are affected, except for the one on my desk.
> 
> Sorry for the churn.
> 

So, I folded that one in the previous one and updated my pull request.
Hopefully this will be OK.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
