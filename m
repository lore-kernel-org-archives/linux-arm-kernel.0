From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Oct 2013 15:55:48 +0800
Subject: [PATCH 01/11] usb: chipidea: Add power management support
In-Reply-To: <20131014100458.4f577d01@ipc1.ka-ro>
References: <1381570513-24927-1-git-send-email-peter.chen@freescale.com>
 <1381570513-24927-2-git-send-email-peter.chen@freescale.com>
 <20131014100458.4f577d01@ipc1.ka-ro>
Message-ID: <20131014075547.GA26191@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 10:04:58AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Peter Chen wrote:
> > This commit adds runtime and system power management support for
> > chipidea core. The runtime pm support is controlled by glue
> > layer, it can be enabled by flag CI_HDRC_SUPPORTS_RUNTIME_PM.
> > 
> [...]
> > +#ifdef CONFIG_PM
> > +static int ci_controller_suspend(struct device *dev)
> > +{
> > +	struct ci_hdrc *ci = dev_get_drvdata(dev);
> > +
> > +	dev_dbg(dev, "at %s\n", __func__);
> > +
> > +	if (atomic_read(&ci->in_lpm))
> > +		return 0;
> > +
> What does this 'atomic_read()' buy you over just testing/assinging a
> simple integer. Note that just because the function has 'atomic' in
> its name the sequence:
> 	atomic_read();
> ...
> 	atomic_set();
> does not magically become an atomic operation.

I just want the read and set are atomic, not the operations
between atomic_read and atomic_set.

-- 

Best Regards,
Peter Chen
