From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 1 Sep 2010 09:25:19 +0530
Subject: [PATCH 17/74] ST SPEAr: Adding USB Host support
In-Reply-To: <Pine.LNX.4.44L0.1008301007010.1571-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1008301007010.1571-100000@iolanthe.rowland.org>
Message-ID: <4C7DCEA7.3020107@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/30/2010 7:40 PM, Alan Stern wrote:
> On Mon, 30 Aug 2010, Viresh KUMAR wrote:
> 
>> > From: Deepak Sikri <deepak.sikri@st.com>
>> > 
> Missing patch description.
> 

Will add.

>> > +static const struct hc_driver ehci_spear_hc_driver = {
>> > +	.description		= hcd_name,
>> > +	.product_desc		= "SPEAr EHCI",
>> > +	.hcd_priv_size		= sizeof(struct spear_ehci),
>> > +
>> > +	/* generic hardware linkage */
>> > +	.irq			= ehci_irq,
>> > +	.flags			= HCD_MEMORY | HCD_USB2,
>> > +
>> > +	/* basic lifecycle operations */
>> > +	.reset			= ehci_spear_setup,
>> > +	.start			= ehci_run,
>> > +	.stop			= ehci_stop,
>> > +	.shutdown		= ehci_shutdown,
>> > +
>> > +	/* managing i/o requests and associated device resources */
>> > +	.urb_enqueue		= ehci_urb_enqueue,
>> > +	.urb_dequeue		= ehci_urb_dequeue,
>> > +	.endpoint_disable	= ehci_endpoint_disable,
>> > +
> Missing .endpoint_reset.

Will add.

viresh.
