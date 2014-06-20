From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 20 Jun 2014 16:14:30 +0200
Subject: [PATCH] ARM: mvebu: use system controller to get the soc id when
 possible
In-Reply-To: <7626280.9GaTg8UqFK@wuerfel>
References: <1403273174-19146-1-git-send-email-gregory.clement@free-electrons.com>
 <7626280.9GaTg8UqFK@wuerfel>
Message-ID: <53A441C6.1040700@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 20/06/2014 16:11, Arnd Bergmann wrote:
> On Friday 20 June 2014 16:06:14 Gregory CLEMENT wrote:
>> +int mvebu_systeme_controller_get_soc_id(u32 *dev, u32 *rev)
> 
> s/systeme/system/
> 
>> +{
>> +       if (of_machine_is_compatible("marvell,armada38x") &&
>> +               system_controller_base) {
>> +               *dev = readl(system_controller_base + mvebu_sc->dev_id) >> 16;
>> +               *rev = (readl(system_controller_base + mvebu_sc->rev_id) >> 8)
>> +                       & 0xF;
>> +               return 0;
>> +       } else
>> +               return -1;
>> +}
> 
> Better return a proper errno code here rather than -1. How about -ENODEV?

OK so I will also fix the mvebu_get_soc_id function


Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
