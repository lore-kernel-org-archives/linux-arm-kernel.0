From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 26 Jun 2012 10:39:59 +0530
Subject: [PATCH v3 4/4] memory: emif: add device tree support to emif
 driver
In-Reply-To: <20120625182830.GA23850@kroah.com>
References: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com>
 <1339669764-27244-5-git-send-email-santosh.shilimkar@ti.com>
 <20120614154820.GG17140@kroah.com>
 <CAMQu2gx5CCDyrvozX06neBnA8J2heg+HL7DOewDm5voxqbpetw@mail.gmail.com>
 <CAMQu2gy7oj-+1qCteAFMXEeOL-Wdrs6e4gKWM=HsOukXcPuv-A@mail.gmail.com>
 <20120625182830.GA23850@kroah.com>
Message-ID: <CAMQu2gxDG=69X7UQPUoTLP5h1ZLpHngp=3C4vSDOS6L-N2XZSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 11:58 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 19, 2012 at 02:33:11PM +0530, Shilimkar, Santosh wrote:
> > @@ -1644,11 +1923,23 @@ static void __attribute__((unused))
> > freq_post_notify_handling(void)
> > ? ? ? spin_unlock_irqrestore(&emif_lock, irq_state);
> > ?}
> >
> > +#if defined(CONFIG_OF)
> > +static const struct of_device_id emif_of_match[] = {
> > + ? ? ? ? ? ? { .compatible = "ti,emif-4d" },
> > + ? ? ? ? ? ? { .compatible = "ti,emif-4d5" },
> > + ? ? ? ? ? ? {},
> > +};
> > +MODULE_DEVICE_TABLE(of, emif_of_match);
> > +#endif
> > +
> > ?static struct platform_driver emif_driver = {
> > ? ? ? .remove ? ? ? ? = __exit_p(emif_remove),
> > ? ? ? .shutdown ? ? ? = emif_shutdown,
> > ? ? ? .driver = {
> > ? ? ? ? ? ? ? .name = "emif",
> > +#if defined(CONFIG_OF)
> > + ? ? ? ? ? ? .of_match_table = of_match_ptr(emif_of_match),
> > +#endif
>
> Are these two still #if defined needed?
>
> Also, what about the IS_DEFINED macro?
>
Yes. To avoid the build break in !DT build.

> And, if you resend, please resend the whole series, I don't have the old
> ones around anymore.
>
Ok. Will repost the entire series.
As mentioned earlier, the series needs to go via OMAP tree beasue the
other three
patches are touching the platform files. I will need your ack on the
$subject patch
to queue that via Tony's linux-omap tree.

Regards
Santosh
