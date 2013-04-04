From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Fri, 5 Apr 2013 01:15:02 +0200
Subject: [PATCH v4 00/14] ARM: samsung-time: Prepare for multiplatform
 support
In-Reply-To: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
Message-ID: <201304050115.03879.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 4. April 2013, 18:36:57 schrieb Tomasz Figa:
> This series is an attempt to make the samsung-time clocksource driver ready
> for multiplatform kernels. It moves the driver to drivers/clocksource,
> cleans it up from uses of static platform-specific definitions, simplifies
> timer interrupt handling and adds Device Tree support.
> 
> Only samsung-time driver is reworked to use the master driver at this time,
> since the PWM driver can be already considered broken at the moment and
> needs separate series of several patches to fix and clean it up, which
> I am already working on.
> 
> Tested on Universal C210 board with Device Tree. Not tested without
> Device Tree, since it has been already broken before this series.
> Compile tested for other related SoCs.

Looks nice.

On a non-DT S3C2416 board:
Tested-by: Heiko Stuebner <heiko@sntech.de>


And just so I don't search myself silly, am I right in thinking that the 
driver does not use the generic clocksource registration yet and dt machines 
must still use samsung_timer_init at this point?


Heiko
