From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Fri, 28 Jul 2017 09:53:35 -0700
Subject: [RESEND PATCH] soc: ti: ti_sci_pm_domains: Populate name for genpd
In-Reply-To: <6f5e2270-af5f-faa3-0ec3-66948d911c87@ti.com>
References: <20170728163333.704-1-d-gerlach@ti.com>
 <6f5e2270-af5f-faa3-0ec3-66948d911c87@ti.com>
Message-ID: <9f2a3c84-0c79-fe15-01ee-d8302bf079f8@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/28/17 9:35 AM, Dave Gerlach wrote:
> Hi,
> On 07/28/2017 11:33 AM, Dave Gerlach wrote:
>> Commit b6a1d093f96b ("PM / Domains: Extend generic power domain
>> debugfs") now creates a debugfs directory for each genpd based on the
>> name of the genpd. Currently no name is given to the genpd created by
>> ti_sci_pm_domains driver so because of this we see a NULL pointer
>> dereferences when it is accessed on boot when the debugfs entry creation
>> is attempted.
>>
>> Give the genpd a name before registering it to avoid this.
>>
>> Fixes: 52835d59fc6c ("soc: ti: Add ti_sci_pm_domains driver")
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
> 
> Sorry for the noise, last patch had wrong email for Santosh and this one
> corrects it. keystone-k2g-evm is crashing on linux-next at boot due to patch
> mentioned in the change log, this patch fixes the ti_sci_pm_domains driver to
> avoid this. I will also soon send a patch to address what I think is an issue in
> the pm domain framework itself to avoid this crash from ever happening.
> 
Applied. Should show up in next soon !!

Regards,
Santosh
