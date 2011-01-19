From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 19 Jan 2011 12:10:48 +0530
Subject: [PATCH V4 32/62] ST SPEAr 13xx : Adding support for SPEAr1310
In-Reply-To: <4D366B07.5040509@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<24e7a018145fb94f298ac620919ec4f0a1bf7517.1295333958.git.viresh.kumar@st.com>
	<20110119000919.GB2209@gallagher> <4D366B07.5040509@st.com>
Message-ID: <4D368770.7030808@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2011 10:09 AM, viresh kumar wrote:
>>> >> +
>>> >> +#ifdef CONFIG_PCIEPORTBUS
>>> >> +/* this function is needed for PCIE host and device driver. Same
>>> >> + * controller can not be programmed as host as well as device. So host
>>> >> + * driver must call this function and if this function returns 1 then
>>> >> + * only host should add that particular port as RC.
>>> >> + * A port to be added as device, one must also add device's information
>>> >> + * in plat_devs array defined in this file.
>>> >> + * it is the responsibility of calling function to not send port number
>>> >> + * greter than max no of controller(3)
>>> >> + */
>>> >> +int spear1310_pcie_port_is_host(int port)
>>> >> +{
>>> >> +	switch (port) {
>>> >> +	case 0:
>>> >> +		return 0;
>>> >> +	case 1:
>>> >> +		return 1;
>>> >> +	case 2:
>>> >> +		return 1;
>>> >> +	}
>>> >> +	return -EINVAL;
>>> >> +}
>>> >> +#endif
>> > 
>> > It looks like this can be made static.  Also, given the comment, is it worth 
>> > adding a BUG_ON(port > 3)?
>> > 
> will be done. BUG_ON() can be added here.
> 

There is another thought here. We may not require a BUG_ON here.
Returning error would be better, so that driver can take steps accordingly.
Also it is not that much blocking of a issue, that we need BUG_ON.

--
viresh
