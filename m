From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 4 Apr 2013 12:44:06 +0530
Subject: [PATCH v8 10/14] ARM: tegra: Define Tegra114 CAR binding
In-Reply-To: <20130403141916.GS18519@tbergstrom-lnx.Nvidia.com>
References: <1363956029-31873-1-git-send-email-pdeschrijver@nvidia.com>
 <1363956029-31873-11-git-send-email-pdeschrijver@nvidia.com>
 <515031E3.40007@nvidia.com>
 <20130403141916.GS18519@tbergstrom-lnx.Nvidia.com>
Message-ID: <515D283E.5060209@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 April 2013 07:49 PM, Peter De Schrijver wrote:
> On Mon, Mar 25, 2013 at 12:15:47PM +0100, Prashant Gaikwad wrote:
>> On Friday 22 March 2013 06:09 PM, Peter De Schrijver wrote:
>>> The device tree binding models Tegra114 CAR (Clock And Reset) as a single
>>> monolithic clock provider.
>>>
>>> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>> ---
>> <snip>
>>
>>> +  263	cclk_lp
>>> +  264	dfll_ref
>>> +  265	dfll_soc
>>> +
>> Peter,
>>
>> Please remove following clock IDs from binding.
>>
>>> +Mux clocks
>>> +
> ...
>>> +  306	clk_out_1_mux
> Is at least used by the init list. So we can't remove that?

Init list is internal to driver and does not use device tree, so we can 
keep that ID in enum but remove from DT binding so that we don't have to 
change the binding later.

>
> Cheers,
>
> Peter.
