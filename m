From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Fri, 18 Jul 2014 19:13:52 +0300
Subject: [PATCH v2 0/4] Support for Qualcomm QPNP PMIC's
In-Reply-To: <53C857DE.7030507@codeaurora.org>
References: <1405613855-27572-1-git-send-email-svarbanov@mm-sol.com>
 <53C857DE.7030507@codeaurora.org>
Message-ID: <53C947C0.5020604@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2014 02:10 AM, Stephen Boyd wrote:
> On 07/17/14 09:17, Stanimir Varbanov wrote:
>> Hello everyone,
>>
>> Here is the continuation of patch sets sent recently about Qualcomm
>> QPNP SPMI PMICs.
>>
>> The previous version of the patch set can be found at [1].
>>
>> Changes since v1:
>>  - removed completely custom *of* parser
>>  - renamed the mfd driver from qpnp-spmi to pm8xxx-spmi
>>  - now MFD_PM8XXX_SPMI Kconfig option depends on SPMI
>>
>> Removing of the custom *of* parser leads to that that the *reg* devicetree
>> property cannot exist and therefore cannot be parsed to get PMIC peripheral
>> resources. I took this step aside because no one from mfd drivers does this
>> parsing. This will lead to inconvenience in the peripheral drivers to define
>> internally the SPMI base addresses depending on the compatible property
>> i.e. PMIC version. 
> 
> We should teach the of platform layer to translate reg properties up
> until the point that they can't be translated anymore. If they can't be
> translated all the way back to cpu addresses we can make the resource
> have IORESOURCE_REG instead of IORESOURCE_MEM and then said pmic
> platform drivers can use platform_get_resource() with IORESOURCE_REG
> instead of IORESOURCE_MEM to get the addresses.
> 

I considered this as an option, if it is acceptable by OF maintainers it
will be awesome.

Rob, Grant, is that feasible?

-- 
regards,
Stan
