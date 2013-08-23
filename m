From: zonque@gmail.com (Daniel Mack)
Date: Fri, 23 Aug 2013 18:21:01 +0200
Subject: [PATCH v4 2/5] net: ethernet: cpsw: add optional third memory
 region for CONTROL module
In-Reply-To: <521778DB.7040402@cogentembedded.com>
References: <1377267365-24057-1-git-send-email-zonque@gmail.com>
 <1377267365-24057-3-git-send-email-zonque@gmail.com>
 <521778DB.7040402@cogentembedded.com>
Message-ID: <52178BED.1070308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.08.2013 16:59, Sergei Shtylyov wrote:
> On 23-08-2013 18:16, Daniel Mack wrote:

>> +	priv->gmii_sel_reg = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(priv->gmii_sel_reg)) {
>> +		dev_err(priv->dev, "unable to map control i/o region\n");
> 
>     You didn't actually seem to heed my words about error message.

Well yes I did, but only in the check for platform_get_resource(). As
the comment says - we pass on if that memory region is not given, but if
it is given, it also has to be valid.

> And don't  you want to do:
> 
> 	res = PTR_ERR(priv->gmii_sel_reg);


Erm, of course. Sorry for that.


Daniel
