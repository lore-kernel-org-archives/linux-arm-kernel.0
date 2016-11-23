From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 22 Nov 2016 19:00:58 -0800
Subject: [PATCH 2/2] PCI: iproc: avoid maybe-uninitialized warning
In-Reply-To: <2504851.C6gOdhdaGF@wuerfel>
References: <20161122141844.1655574-1-arnd@arndb.de>
 <20161122141844.1655574-2-arnd@arndb.de>
 <31c4c52b-3de5-2277-7a44-2a4231531074@broadcom.com>
 <2504851.C6gOdhdaGF@wuerfel>
Message-ID: <d3d3f706-1656-e193-0fbd-4cb3126b3769@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/22/2016 1:15 PM, Arnd Bergmann wrote:
> On Tuesday, November 22, 2016 9:45:24 AM CET Ray Jui wrote:
>>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>>> index 857ff5198317..0359569c8d78 100644
>>> --- a/drivers/pci/host/pcie-iproc.c
>>> +++ b/drivers/pci/host/pcie-iproc.c
>>> @@ -936,6 +936,7 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
>>>  
>>>               }
>>>       }
>>> +     ret = -EINVAL;
>>>  err_ib:
>>>       dev_err(dev, "unable to configure inbound mapping\n");
>>>       dev_err(dev, "axi %pap, pci %pap, res size %pap\n",
>>>
>>
>> This change is good, but in my opinion, a further improvement for
>> clarity would be to initialize 'ret' to -EINVAL in the beginning of this
>> function when 'ret' is declared. What do you think?
>>
> 
> I never do that, see https://rusty.ozlabs.org/?p=232 for a great
> explanation about why.
> 
> 	Arnd
> 

Okay got it. Thanks!

Ray
