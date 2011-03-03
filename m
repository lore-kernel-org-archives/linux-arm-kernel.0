From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 02 Mar 2011 19:38:24 -0800
Subject: [Qualcomm PM8921 MFD 1/6] mfd: pm8921: Add PMIC 8921 core driver
In-Reply-To: <20110302222850.GA32325@opensource.wolfsonmicro.com>
References: <1299104001-5240-1-git-send-email-adharmap@codeaurora.org>
	<1299104001-5240-2-git-send-email-adharmap@codeaurora.org>
	<20110302222850.GA32325@opensource.wolfsonmicro.com>
Message-ID: <4D6F0D30.1050403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> On Wed, Mar 02, 2011 at 02:13:16PM -0800, adharmap at codeaurora.org wrote:
> 
>> +config MFD_PM8XXX
>> +	tristate "Support for Qualcomm PM8xxx subdevices"
>> +	help
>> +	  This option enables the usage of various Qualcomm PMIC 8xxx subdevice
>> +	  drivers. This is required in order to use generic PM8xxx subdevice
>> +	  drivers. Selecting with option will result in PM8xxx subdevice
>> +	  drivers being compiled by default.
> 
> As this is selected by the driver it shouldn't have any help text -
> there's no point in users seeing the option since it's useless by
> itself.  If we get enough to make an option useful either a menu or
> dependencies from the individual MFDs would be a better option.

Agree will fix this.
> 
>> +static int __devinit pm8921_add_subdevices(const struct pm8921_platform_data
>> +					   *pdata,
>> +					   struct pm8921 *pmic)
>> +{
>> +	return 0;
>> +}
> 
> This looks suspicious.

True, the next patch fills in this function. Will remove it from here.

> 
>> +static int __init pm8921_init(void)
>> +{
>> +	return platform_driver_register(&pm8921_driver);
>> +}
>> +postcore_initcall(pm8921_init);
> 
> Typically subsys_initcall() has been used.

Yes will change this and others to subsys_initcall()


--
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.
