From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 21 Mar 2014 15:06:44 +0100
Subject: [PATCH v4 1/9] PCI: host: rcar: Add Renesas R-Car PCIe driver
In-Reply-To: <OF038A7DC3.59E6288A-ON80257CA2.004AF404-80257CA2.004CDD76@eu.necel.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
 <1395397968-6242-2-git-send-email-phil.edworthy@renesas.com>
 <27671657.LuGQtNBfqX@wuerfel>
 <OF038A7DC3.59E6288A-ON80257CA2.004AF404-80257CA2.004CDD76@eu.necel.com>
Message-ID: <532C4774.20803@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/14 14:59, Phil.Edworthy at renesas.com wrote:
> Hi Arnd,
>
> Thanks for the review.
>
>
>>> +static int __init pcie_init(void)
>>> +{
>>> +   return platform_driver_probe(&rcar_pcie_driver, rcar_pcie_probe);
>>> +}
>>> +subsys_initcall(pcie_init);
>>
>> Why so early?
> Good catch, copied from another PCIe driver!

I think you can change it to use module_driver() instead of the
init_call.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
