From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 14 Jan 2017 11:25:18 +0800
Subject: [PATCH v7 08/15] ACPI: IORT: rename iort_node_map_rid() to make
 it generic
In-Reply-To: <20170113114747.GD20837@red-moon>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <1484147199-4267-9-git-send-email-hanjun.guo@linaro.org>
 <20170113114747.GD20837@red-moon>
Message-ID: <58799A1E.9070708@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/1/13 19:47, Lorenzo Pieralisi wrote:
> On Wed, Jan 11, 2017 at 11:06:32PM +0800, Hanjun Guo wrote:
>> iort_node_map_rid() was designed for both PCI and platform
>> device, but the rid means requester id is for ITS mappings,
> I do not understand what this means sorry.
>
>> rename iort_node_map_rid() to iort_node_map_id() and update
>> its argument names to make it more generic.
>>
> "iort_node_map_rid() was designed to take an input id (that is not
> necessarily a PCI requester id) and map it to an output id (eg an SMMU
> streamid or an ITS deviceid) according to the mappings provided by an
> IORT node mapping entries. This means that the iort_node_map_rid() input
> id is not always a PCI requester id as its name, parameters and local
> variables suggest, which is misleading.
>
> Apply the s/rid/id substitution to the iort_node_map_rid() mapping
> function and its users to make sure its intended usage is clearer."

Thank your patience, I will update the commit message.

Hanjun
