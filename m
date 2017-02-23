From: jk@ozlabs.org (Jeremy Kerr)
Date: Thu, 23 Feb 2017 22:24:10 +0800
Subject: [PATCH v3 01/18] drivers/fsi: Add empty fsi bus definitions
In-Reply-To: <CAMuHMdUhiXCnjT60Lsqq4eGGnVv9eavtkVL1Mdk_6naBHBDVrQ@mail.gmail.com>
References: <20170201165358.45415-1-cbostic@linux.vnet.ibm.com>
 <20170201165358.45415-2-cbostic@linux.vnet.ibm.com>
 <CAMuHMdUhiXCnjT60Lsqq4eGGnVv9eavtkVL1Mdk_6naBHBDVrQ@mail.gmail.com>
Message-ID: <53c63405-8aeb-9751-62d6-4583847dce3c@ozlabs.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

>> --- /dev/null
>> +++ b/drivers/fsi/Kconfig
>> @@ -0,0 +1,12 @@
>> +#
>> +# FSI subsystem
>> +#
>> +
>> +menu "FSI support"
>> +
>> +config FSI
>> +       tristate "FSI support"
> 
> I guess this should depend on some POWER symbol || COMPILE_TEST?

No, this is pretty hardware-independent - all it requires on the HW side
is two GPIOs.

Although the FSI slave devices are typically only present on POWER
systems, they can be driven from anything, with currently
implementations being on ARM and 32-bit powerpc.

Cheers,


Jeremy
