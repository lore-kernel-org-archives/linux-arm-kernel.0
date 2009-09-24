From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Sep 2009 21:34:37 +0100
Subject: Problem with s3c24xx pwm driver
In-Reply-To: <200909241733.29167.anarsoul@gmail.com>
References: <200909231824.11671.anarsoul@gmail.com>
	<200909232223.35835.anarsoul@gmail.com>
	<f17812d70909231525t594704c5u781e2221481676a0@mail.gmail.com>
	<200909241733.29167.anarsoul@gmail.com>
Message-ID: <20090924203437.GA25389@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2009 at 05:33:24PM +0300, Vasily Khoruzhick wrote:
> Ok, I've found source of  problem: it seems to be some issue with backlight 
> LED driver (hardware, not software) with selected PWM clock. It seems that  
> part of period with "1" is not long enought to charge capacitor, or something 
> like this. PWM itself works fine.

Is it LED or is it CCFL?  If it's CCFL, it needs to be 'struck' and then
you can reduce the intensity level - by going to max brightness when you
turn it on and then back the intensity down.

That's fairly normal for CCFL stuff.
