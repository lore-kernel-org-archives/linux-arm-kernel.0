From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 11 Mar 2011 23:53:11 +0200
Subject: [PATCH 5/8] ARM: PXA: Z2: Add poweroff function
In-Reply-To: <201103112239.03751.marek.vasut@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<1299839023-16601-5-git-send-email-anarsoul@gmail.com>
	<201103112239.03751.marek.vasut@gmail.com>
Message-ID: <201103112353.11261.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 23:39:03 Marek Vasut wrote:
> On Friday 11 March 2011 11:23:40 Vasily Khoruzhick wrote:
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> This looks bogus to me as you cannot power down the thing. Besides, where
> do you resume to from this so-called "powerdown" ? Since the bootloader
> will consider it as a legitimate deepsleep resume.

It eats only 0.7mA in deepsleep, but 6.7mA in sleep (PXA2xx has 2 sleep 
modes), so deepsleep is pretty close to poweroff. Bootloader behaves correctly 
(at least u-boot binary I'm using) - it starts boot process after deepsleep. 
Looks like hardware is somehow configured to disable almost everything in 
deepsleep mode, RAM content is not preserved anyway, so we can't resume 
properly.
