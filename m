From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 31 May 2018 13:47:48 +0100
Subject: [PATCH v3 4/5] PM / Domains: Add support for multi PM domains per
 device to genpd
In-Reply-To: <5fc1d3ee51c8dbc264fb21edf33a879c7db4056b.camel@lynxeye.de>
References: <20180531105959.14843-1-ulf.hansson@linaro.org>
 <20180531105959.14843-5-ulf.hansson@linaro.org>
 <5fc1d3ee51c8dbc264fb21edf33a879c7db4056b.camel@lynxeye.de>
Message-ID: <191ed832-3b15-f47d-c171-4039da665b36@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 31/05/18 12:40, Lucas Stach wrote:
> Hi Ulf,
> 
> Am Donnerstag, den 31.05.2018, 12:59 +0200 schrieb Ulf Hansson:
>> To support devices being partitioned across multiple PM domains, let's
>> begin with extending genpd to cope with these kind of configurations.
>>
>> Therefore, add a new exported function genpd_dev_pm_attach_by_id(), which
>> is similar to the existing genpd_dev_pm_attach(), but with the difference
>> that it allows its callers to provide an index to the PM domain that it
>> wants to attach.
>>
>> Note that, genpd_dev_pm_attach_by_id() shall only be called by the driver
>> core / PM core, similar to how the existing dev_pm_domain_attach() makes
>> use of genpd_dev_pm_attach(). However, this is implemented by following
>> changes on top.
> 
> by_id() APIs are not really intuitive to use for driver writers. Other
> subsystems have solved this by providing a "-names" property to give
> the phandles a bit more meaning and then providing a by_name API. I
> would really appreciate if PM domains could move in the same direction.

As discussed here [0], there are plans to add that.

Cheers
Jon

[0] https://patchwork.ozlabs.org/patch/921938/

-- 
nvpublic
