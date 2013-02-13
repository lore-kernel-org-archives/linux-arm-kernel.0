From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 Feb 2013 09:08:09 +0000
Subject: [PATCH v2 10/13] mailbox: create dbx500 mailbox driver
In-Reply-To: <511A9F81.1040608@st.com>
References: <1360645032-9668-1-git-send-email-s-anna@ti.com>
 <1360645032-9668-11-git-send-email-s-anna@ti.com>
 <20130212103949.GA826@e106331-lin.cambridge.arm.com>
 <511A9F81.1040608@st.com>
Message-ID: <20130213090809.GD13775@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 08:01:05PM +0000, Loic PALLARDY wrote:
> Hi Mark,
> 
> Thanks for your comments.
> 
> On 02/12/2013 11:39 AM, Mark Rutland wrote:
> > Hello,
> >
> > I have a few comments on the devicetree binding and the way it's parsed.
> >
> >> +static const struct of_device_id dbx500_mailbox_match[] = {
> >> +       { .compatible = "stericsson,db8500-mailbox",
> >> +               .data = (void *)db8500_mboxes,
> >> +       },
> >> +       { .compatible = "stericsson,db9540-mailbox",
> >> +               .data = (void *)dbx540_mboxes,
> >> +       },
> >> +       { /* sentinel */}
> >> +};
> >> +
> >
> > The binding for the compatible strings above and property parsing below should
> > be documented.
> >
> Yes you're right. I will add a description in 
> Documentation/devicetree/bindings/mailbox/...

Great!

[...]

> >> +       mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "prcm_reg");
> >
> > Does this work for dt? I wasn't aware we got anything more than anonymous
> > memory and interrupts.
> >
> Yes this is working with and without dt.
> dt declaration will be the following
> mailbox {
> 	compatible = "stericsson,db8500-mailbox";
> 	reg = <0x80157000 0x1000>, <0x801B8000 0x2000>;
> 	reg-names = "prcm-reg", "prcmu-tcdm";
> 	interrupts = <0 47 0x4>;
> 	interrupt-names = "irq";
> 	legacy-offset = <0xdd4>;
> };

Ah, I wasn't aware of reg-names. Thanks for the example.

Thanks,
Mark.
