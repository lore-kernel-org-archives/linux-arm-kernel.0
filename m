From: vitalywool@gmail.com (Vitaly Wool)
Date: Mon, 23 Nov 2009 21:22:44 +0300
Subject: [PATCH 07/10] ARM: PNX4008: move i2c suspend/resume callbacks
	into driver
In-Reply-To: <20091121125347.GE7998@n2100.arm.linux.org.uk>
References: <20091120144422.GA18223@n2100.arm.linux.org.uk>
	<E1NBUkU-0004Pm-Nv@rmk-PC.arm.linux.org.uk>
	<20091121125347.GE7998@n2100.arm.linux.org.uk>
Message-ID: <acd2a5930911231022i60eda84di12799fb4a55faab9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2009 at 3:53 PM, Russell King - ARM Linux <
linux@arm.linux.org.uk> wrote:

> On Fri, Nov 20, 2009 at 10:50:34AM +0000, Russell King - ARM Linux wrote:
> > -static int i2c_pnx_suspend(struct platform_device *pdev, pm_message_t
> state)
> > -{
> > -     int retval = 0;
> > -#ifdef CONFIG_PM
> > -     retval = set_clock_run(pdev);
> > -#endif
>
> BTW, a comment from PNX folk (Vitaly/Kevin) would be appreciated.  Why
> does PNX enable the clock when going into suspend?  Should I assume that
> this should actually be disabling the clock?
>

As far as I recall, at some point there was a function that was taking the
second boolean parameter (enable or disable the clock). So now it is, yes,
not making much sense.


> Also, if Vitaly doesn't have anything to do with PNX4008 anymore, it
> would be a good idea to update the MAINTAINERS file.
>

I'd like to keep maintaining this platform, but it's also up to NXP because
I don't have the actual working hardware now so there's not much I can do.

Vitaly
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091123/e92db2c0/attachment-0001.htm>
