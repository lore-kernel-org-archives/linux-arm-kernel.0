From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 16 Nov 2010 23:12:58 +0000
Subject: [PATCH 2/2] h1940-leds: Fix compile issue introduced by
	latch-related changes
In-Reply-To: <1289248308-21272-2-git-send-email-anarsoul@gmail.com>
References: <1289248308-21272-1-git-send-email-anarsoul@gmail.com>
	<1289248308-21272-2-git-send-email-anarsoul@gmail.com>
Message-ID: <4CE30FFA.7000204@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/10 20:31, Vasily Khoruzhick wrote:
> Latch API was converted to gpiolib API as result we got this compile
> error:
> 
> drivers/leds/leds-h1940.c: In function 'h1940_greenled_set':
> drivers/leds/leds-h1940.c:33: error: implicit declaration of function
> 'h1940_latch_control
> 
> Adapt h1940-leds driver to new changes and fix compile issue.
> 

it's a pitty we can't remove the driver totally and use the
gpio leds.
