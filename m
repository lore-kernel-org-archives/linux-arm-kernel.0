From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 12:53:47 +0000
Subject: [PATCH 07/10] ARM: PNX4008: move i2c suspend/resume callbacks
	into driver
In-Reply-To: <E1NBUkU-0004Pm-Nv@rmk-PC.arm.linux.org.uk>
References: <20091120144422.GA18223@n2100.arm.linux.org.uk>
	<E1NBUkU-0004Pm-Nv@rmk-PC.arm.linux.org.uk>
Message-ID: <20091121125347.GE7998@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 10:50:34AM +0000, Russell King - ARM Linux wrote:
> -static int i2c_pnx_suspend(struct platform_device *pdev, pm_message_t state)
> -{
> -	int retval = 0;
> -#ifdef CONFIG_PM
> -	retval = set_clock_run(pdev);
> -#endif

BTW, a comment from PNX folk (Vitaly/Kevin) would be appreciated.  Why
does PNX enable the clock when going into suspend?  Should I assume that
this should actually be disabling the clock?

Also, if Vitaly doesn't have anything to do with PNX4008 anymore, it
would be a good idea to update the MAINTAINERS file.
