From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 18 Sep 2015 15:10:11 +0200
Subject: [PATCH v4 1/3] leds: netxbig: add device tree binding
In-Reply-To: <55FBEC38.6020209@samsung.com>
References: <1442505571-9744-1-git-send-email-simon.guinot@sequanux.org>
 <1442505571-9744-2-git-send-email-simon.guinot@sequanux.org>
 <55FBD679.2020402@samsung.com>
 <20150918103006.GM7306@kw.sim.vm.gnt>
 <55FBEC38.6020209@samsung.com>
Message-ID: <20150918131011.GN7306@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 12:49:28PM +0200, Jacek Anaszewski wrote:
> >>
> >>Moreover, if you switched to using devm* prefixed version of
> >>gpio_request_one and led_classdev_reqister, you could simplify
> >>the error paths in the driver.
> >
> >Yes, I have a pending patch for this conversion. But since it is not
> >really related with the subject of this patch series (add DT support),
> >I was planning to send it next.
> >
> >Do you want me to include this patch into this series.
> 
> Why not, if you have it ready to go. If it needs some polishing,
> we can live with what we have now.

No, the patch is ready. I'll add it.

> >>>+static const struct of_device_id of_netxbig_leds_match[] = {
> >>>+	{ .compatible = "lacie,netxbig-leds", },
> >>>+	{},
> >>>+};
> >>>+#else
> >>>+static int netxbig_leds_get_of_pdata(struct device *dev,
> >>>+				     struct netxbig_led_platform_data *pdata)
> >>
> >>s/static int/static inline int/
> >
> >Is that not already the case with modern compiler ?
> 
> Could you elaborate on this?

There is not much to say. netxbig_leds_get_of_pdata is a single line of
code. I am not a gcc expert but I am quite confident that this function
will be inlined anyway (given the optimisation level used to compile the
Linux kernel). That's it.

But there is nothing wrong by adding "inline" neither.

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/0ce39947/attachment.sig>
