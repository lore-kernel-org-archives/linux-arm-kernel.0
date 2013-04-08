From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 08 Apr 2013 20:46:39 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSF0gcmVndWxhdG9yOiBtYzEzNzgzOiBBZGQgZGV2aWNl?=
 =?UTF-8?B?IHRyZWUgcHJvYmUgc3VwcG9ydA==?=
In-Reply-To: <20130407192157.GQ6597@opensource.wolfsonmicro.com>
References: <1365354131-9770-1-git-send-email-shc_work@mail.ru>
 <20130407192157.GQ6597@opensource.wolfsonmicro.com>
Message-ID: <1365439599.786794300@f48.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> On Sun, Apr 07, 2013 at 09:02:11PM +0400, Alexander Shiyan wrote:
> > Patch adds device tree probe support for mc13783-regulator driver.
> 
> I'd expect to see a document describing the binding for any new binding.
OK.
 
> > +	if (num_parsed != num_regulators) {
> > +		dev_warn(&pdev->dev,
> > +		"parsed %d != regulators %d - check your device tree!\n",
> > +			num_parsed, num_regulators);
> >  
> > -		init_data = &pdata->regulators[i];
> > -		desc = &mc13783_regulators[init_data->id].desc;
> > +		num_regulators = num_parsed;
> > +		priv->num_regulators = num_regulators;
> 
> Why is this something we warn about?  Users should be able to omit
> unused regulators, no point in adding nodes that don't have any real
> information.

Warning is appear on nonexistent regulators names only.
I will rewrite warning procedure in the v2 globally for mc13xx.
Thanks.

---
