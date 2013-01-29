From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Tue, 29 Jan 2013 18:03:13 +0530
Subject: [PATCH 2/2] drivers: net:ethernet: cpsw: add support for VLAN
In-Reply-To: <20130129073626.GB18272@localhost.localdomain>
References: <1359403945-28585-1-git-send-email-mugunthanvnm@ti.com>
 <1359403945-28585-3-git-send-email-mugunthanvnm@ti.com>
 <20130129073626.GB18272@localhost.localdomain>
Message-ID: <5107C189.1050604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/29/2013 1:06 PM, Richard Cochran wrote:
> On Tue, Jan 29, 2013 at 01:42:25AM +0530, Mugunthan V N wrote:
>> @@ -947,6 +1042,10 @@ static const struct net_device_ops cpsw_netdev_ops = {
>>   #ifdef CONFIG_NET_POLL_CONTROLLER
>>   	.ndo_poll_controller	= cpsw_ndo_poll_controller,
>>   #endif
>> +#ifdef VLAN_SUPPORT
>> +	.ndo_vlan_rx_add_vid	= cpsw_ndo_vlan_rx_add_vid,
>> +	.ndo_vlan_rx_kill_vid	= cpsw_ndo_vlan_rx_kill_vid,
>> +#endif
> These are not compile time conditionals in net_device_ops, so I wonder
> (after reading Felipe's comments) whether you can simply keep the VLAN
> code always present.
>
> As long as the driver still compiles and loads, when VLAN is missing
> from the stack, then I don't see why you can't just leave it in,
> without all the ifdefs.
>
> Thanks,
> Richard
This idea seems to be good. I will update the patch in next version.

Regards
Mugunthan V N
