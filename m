From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Fri, 23 Aug 2013 11:44:20 +0530
Subject: [PATCH 3/4] net: ethernet: cpsw: add support for hardware
 interface mode config
In-Reply-To: <5216F366.50609@ti.com>
References: <1377171448-27924-1-git-send-email-zonque@gmail.com>
 <1377171448-27924-4-git-send-email-zonque@gmail.com> <5216F366.50609@ti.com>
Message-ID: <5216FDBC.3010600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 August 2013 11:00 AM, Sekhar Nori wrote:
>> @@ -728,6 +736,44 @@ static void _cpsw_adjust_link(struct cpsw_slave *slave,
>> >  	u32			mac_control = 0;
>> >  	u32			slave_port;
>> >  
>> > +	if (priv->gmii_sel_reg && of_machine_is_compatible("ti,am33xx")) {
> This sounds like the DT version of cpu_is_am335x()! Looks like you need
> to introduce a new compatible "ti,am3352-cpsw" to indicate the AM3352
> specific features of the CPSW IP (yeah, control module is not really
> part of the IP, but by introducing it in the driver, we are treating it
> such anyway. And you can see this register as extension of IP since its
> not shared for any other purpose).
>

I also agree but it should be ti,am3352-cpsw or ti.am33xx-cpsw?

Regards
Mugunthan V N
