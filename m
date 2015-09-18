From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 18 Sep 2015 15:23:56 +0200
Subject: [PATCH v4 0/3] Add DT support for netxbig LEDs
In-Reply-To: <55FBD641.7030902@samsung.com>
References: <1442505571-9744-1-git-send-email-simon.guinot@sequanux.org>
 <55FBD641.7030902@samsung.com>
Message-ID: <20150918132356.GO7306@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 11:15:45AM +0200, Jacek Anaszewski wrote:
> Hi Simon,
> 
> Thanks for the update.
> 
> On 09/17/2015 05:59 PM, Simon Guinot wrote:
> >Hello,
> >
> >This patch series adds DT support for the LEDs found on the Kirkwood-based
> >LaCie boards 2Big and 5Big Network v2.
> >
> >Changes for v2:
> >- Check timer mode value retrieved from DT.
> >- In netxbig_leds_get_of_pdata, don't use unsigned long variables to get
> >   timer delay values from DT with function of_property_read_u32_index.
> >   Instead, use a temporary u32 variable. This allows to silence a static
> >   checker warning.
> >- Make timer property optional in the binding documentation. It is now
> >   aligned with the driver code.
> >
> >Changes for v3:
> >- Fix pointer usage with the temporary u32 variable while calling
> >   of_property_read_u32_index.
> >
> >Changes for v4:
> >- In DT binding document netxbig-gpio-ext.txt, detail byte order for
> >   registers and latch mechanism for "enable-gpio".
> >- In leds-netxbig.c, add some error messages.
> >- In leds-netxbig.c, fix some "sizeof" style issues.
> >- In leds-netxbig.c, in netxbig_leds_get_of_pdata(), move the
> >   of_property_read_string() calls after the error-prone checks.
> >- Add some Acked-by.
> >
> >Jacek,
> >
> >I did not convert the bright-max DT property into led-max-microamp.
> >The reason is that I can't translate the bright-max values into
> >microamperes.
> 
> Doesn't specification of your device say what current value given
> brightness level reflects?

I double-checked and I can confirm that I don't have the current values
for the LEDs. Although this feature is nice to have, it has not been
used by the LaCie stock firmware. LEDs are only enabled at their maximum
level. I believe it is the reason why it has not been specified...

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/1f0ceccf/attachment.sig>
