From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Jan 2014 10:44:27 +0100
Subject: [PATCH v2 2/5] clk: sunxi: Add USB clock register defintions
In-Reply-To: <52E67316.5020906@redhat.com>
References: <1390426587-16287-1-git-send-email-hdegoede@redhat.com>
 <1390426587-16287-3-git-send-email-hdegoede@redhat.com>
 <20140127144349.GJ3867@lukather> <52E67316.5020906@redhat.com>
Message-ID: <20140128094427.GZ3867@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 03:54:14PM +0100, Hans de Goede wrote:
> >> "allwinner,sun5i-a13-usb-gates-clk" - for usb gates + resets on A13
> > 
> > Maybe we can just remove the gates from there? Even though they
> > are gates, they are also (a bit) more than that.
> 
> To be clear you mean s/usb-gates-clk/usb-clk/ right ?

Yep, exactly

> > I guess that means that we will have the OHCI0 gate declared with
> > <&...-gates-clk 6>, while it's actually the first gate for this
> > clock?
> 
> Correct.
> 
> > Maybe introducing an offset field in the gates_data would be a
> > good idea, so that we always start from indexing the gates from 0
> > in the DT?
> 
> Well for the other "gates" type clks we also have holes in the
> range, and we always refer to the clk with the bit number in the reg
> as the clock-cell value.

Yes, we have holes, but I see two majors differences here:
  - the other gates are just gates, while the usb clocks are a bit
    more than that.
  - the other gates' gating bits thus all start at bit 0, while here,
    since it's kind of a "mixed" clock, the gating bits start at bit 6
    (on the A20 at least)


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140128/4aeec0e2/attachment.sig>
