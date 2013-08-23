From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 23 Aug 2013 21:37:20 +0400
Subject: [PATCH v4 2/5] net: ethernet: cpsw: add optional third memory
 region for CONTROL module
In-Reply-To: <52178BED.1070308@gmail.com>
References: <1377267365-24057-1-git-send-email-zonque@gmail.com>
 <1377267365-24057-3-git-send-email-zonque@gmail.com>
 <521778DB.7040402@cogentembedded.com> <52178BED.1070308@gmail.com>
Message-ID: <52179DD0.4010300@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2013 08:21 PM, Daniel Mack wrote:

>>> +	priv->gmii_sel_reg = devm_ioremap_resource(&pdev->dev, res);
>>> +	if (IS_ERR(priv->gmii_sel_reg)) {
>>> +		dev_err(priv->dev, "unable to map control i/o region\n");

>>      You didn't actually seem to heed my words about error message.

> Well yes I did, but only in the check for platform_get_resource(). As
> the comment says - we pass on if that memory region is not given, but if
> it is given, it also has to be valid.

    Yes, but what I told you was devm_ioremap_resource() prints the error 
messages itself, so that you don't have to. And you even consented with that. :-)

>> And don't  you want to do:

>> 	res = PTR_ERR(priv->gmii_sel_reg);

     Well, I've messed with the variable name: 'res' is struct resource *', 
what I meant was *int* variable.

> Erm, of course. Sorry for that.

> Daniel

WBR, Sergei
