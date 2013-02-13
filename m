From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Feb 2013 09:50:25 -0700
Subject: [v2 3/3] ARM: tegra: Unify Device tree board files
In-Reply-To: <20130213.081240.1605796167151164030.hdoyu@nvidia.com>
References: <20130212.070456.532657136988541923.hdoyu@nvidia.com><201302121350.15683.arnd@arndb.de><511A6F6C.8090205@wwwdotorg.org>
 <20130213.081240.1605796167151164030.hdoyu@nvidia.com>
Message-ID: <511BC451.9050504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2013 11:12 PM, Hiroshi Doyu wrote:
> Stephen Warren <swarren@wwwdotorg.org> wrote @ Tue, 12 Feb 2013 17:35:56 +0100:
> 
>> However I'd like to avoid changing the body of those two functions at
>> all if possible, since I hope the PCIe driver rework will be merged in
>> 3.10, and that will allow the Harmony and TrimSlice init functions to be
>> removed entirely. I'd rather not have conflicts with the removal patch.
>>
>>> Since we are not going to add any other board specfic init functions, you
>>> can also unroll the loop and put everything into tegra_dt_init_late:
>>
>> That's not necessarily true. While we certainly don't plan to, I don't
>> think we can rule it out; after all, we don't have rfkill bindings and
>> yet other boards will need them.
> 
> Considering the above points,
> 
> - The Harmony and TrimSlice init functions will be removed entirely
>   so soon that we want to avoid those merge conflicts as much as
>   possible.
> - We may still need board specific init, especially for rfkill.
> - We want to build any combination of Tegra{20,30,114}, 2^3 - 1 == 7.
> 
> The patch for "tegra.c" would be as below.
> 
> Should I still keep the name, "tegra20_auxdata_lookup" to avoid
> any conflicts or "tegra_auxdata_lookup" would be ok for merge?

Yes, avoiding the rename of the auxdata table might be a good idea.

Aside from that, I think the patch you gave looks fine.
