From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 20 Sep 2013 14:53:08 -0700
Subject: [PATCH v4] clk: si570: Add a driver for SI570 oscillators
In-Reply-To: <20130920181529.GA31173@roeck-us.net>
References: <1379698757-25232-1-git-send-email-soren.brinkmann@xilinx.com>
 <20130920181529.GA31173@roeck-us.net>
Message-ID: <65b27409-d70f-41d2-ace5-9c3fe65ec24d@CO9EHSMHS003.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 11:15:29AM -0700, Guenter Roeck wrote:
> On Fri, Sep 20, 2013 at 10:39:17AM -0700, Soren Brinkmann wrote:
[...]
> > diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
> > new file mode 100644
> > index 0000000..13c2091
> > --- /dev/null
> > +++ b/drivers/clk/clk-si570.c
[...]
> > +static int si570_probe(struct i2c_client *client,
[...]
> > +	/* Read the requested initial output frequency from device tree */
> > +	if (!of_property_read_u32(client->dev.of_node, "clock-frequency",
> > +				&initial_fout)) {
> > +		err = clk_set_rate(clk, initial_fout);
> > +		if (err) {
> > +			of_clk_del_provider(client->dev.of_node);
> > +			clk_unregister(data->hw.clk);
> 
> Is that needed ? I would have thought it isn't because you use a devm_ function
> to register it.
> 
> Not that I understand the clk code, but getting clk from the registration
> function and unregistering hw.clk (without seting it) sems a bit odd.
> Is it well defined that you have to unregister hw.clk ?
You're absolutely right. I'll remove all calls to clk_unregister().
Thanks for finding that one.

	S?ren
