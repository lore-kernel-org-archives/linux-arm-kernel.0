From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 08 Jan 2014 14:42:45 +0100
Subject: [PATCH v4 2/3] ARM: mvebu: Add quirk for i2c
In-Reply-To: <201401081352.57361.arnd@arndb.de>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
 <1389112504-9931-3-git-send-email-gregory.clement@free-electrons.com>
 <201401081352.57361.arnd@arndb.de>
Message-ID: <52CD55D5.6020703@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2014 13:52, Arnd Bergmann wrote:
> On Tuesday 07 January 2014, Gregory CLEMENT wrote:
> 
>>  static void __init armada_370_xp_dt_init(void)
>>  {
>> +       i2c_quirk();
>>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>  }
> 
> I'd prefer to enable the quirk only on machines that we know may be affected, i.e.
> OpenBlocks AX3-4. That would make it easier in the future for everyone to figure
> out whether they need to include the quirk in their kernels or not, depending
> on whether they want to support these machines. Just a precaution in case we
> end up having lots of quirks in the long run.

You means something like the following code ?

static void __init armada_370_xp_dt_init(void)
 {
+       if (of_machine_is_compatible("plathome,openblocks-ax3-4"))
+               i2c_quirk();
        of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }




> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
