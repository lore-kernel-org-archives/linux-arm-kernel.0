From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Mar 2014 15:38:15 +0000
Subject: [PATCH 1/5] drivers: input: keyboard: st-keyscan: add keyscan
 driver
In-Reply-To: <20140310152859.GA29054@core.coreip.homeip.net>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-2-git-send-email-gabriel.fernandez@st.com>
 <20140310114819.GO14976@lee--X1>
 <20140310152859.GA29054@core.coreip.homeip.net>
Message-ID: <20140310153815.GE13661@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > This patch adds ST Keyscan driver to use the keypad hw a subset
> > > of ST boards provide. Specific board setup will be put in the
> > > given dt.
> > > 
> > > Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
> > > Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> > 
> > Are you sure these are in the correct order?
> > 
> > What is the history of this commit?
> > 
> > > ---
> > >  .../devicetree/bindings/input/st-keypad.txt        |  50 ++++
> > 
> > This should be submitted as a seperate patch.
> 
> Why do we have such requirement? To me it would make more sense to add
> binding documentation in the same commit as the code that uses these
> bindings.

I'm inclined to agree with you and that's actually how we used to do
it, but a decision was made by the DT guys at one of the Kernel
Summits to submit Documentation as a separate patch.

> [...]
> 
> > > +
> > > +	error = matrix_keypad_parse_of_params(dev, &pdata->num_out_pads,
> > > +			&pdata->num_in_pads);
> > > +	if (error) {
> > > +		dev_err(dev, "failed to parse keypad params\n");
> > > +		return error;
> > 
> > Nit: It's pretty unusual to use this for a standard error handling
> > variable. Consider 'ret' or 'err' as a replacement.
> 
> I like "error", in fact there are a lot of these in input. I use "error" for
> data that is only returned from error path and "retval" when the same
> variable is returned in both success and error paths.

If that's your preference then I'm cool with it too. Scrap my comment.

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
