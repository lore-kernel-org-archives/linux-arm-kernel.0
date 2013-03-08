From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Mar 2013 11:42:27 -0700
Subject: [PATCH 4/5] ARM: DT: tegra114: add KBC controller DT entry
In-Reply-To: <513A2A6D.7080604@nvidia.com>
References: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
 <1362750782-15174-5-git-send-email-ldewangan@nvidia.com>
 <513A2810.1070903@wwwdotorg.org> <513A2A6D.7080604@nvidia.com>
Message-ID: <513A3113.10909@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 11:14 AM, Laxman Dewangan wrote:
> On Friday 08 March 2013 11:34 PM, Stephen Warren wrote:
>> On 03/08/2013 06:53 AM, Laxman Dewangan wrote:
>>> NVIDIA's Tegra114 SoCs have the matrix keyboard controller which
>>> supports 11x8 type of matrix. The number of rows and columns
>>> are configurable.
>> Earlier Tegra versions supported up to a 16x8 matrix. This feeds into
>> the following defines in the driver:
>>
>> #define KBC_MAX_GPIO    24
>> #define KBC_MAX_ROW     16
>> #define KBC_MAX_COL     8
>> #define KBC_MAX_KEY     (KBC_MAX_ROW * KBC_MAX_COL)
>>
>> Given Tegra114 supports /fewer/ pins and rows than earlier chips, I
>> think that makes the HW technically incompatible, since GPIO IDs 19..23
>> are invalid in this HW but valid earlier.
>>
>> Now in practice I suppose that with a correct DT keyboard map for a
>> Tegra114 device, those extra invalid GPIOs would never be referenced, so
>> this is a little nit-picky, but I still feel we should fix this.
> 
> Where do we fix this? In binding document?

In the driver and .dtsi files; the rest of my message was describing how
to fix this.
