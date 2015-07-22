From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 22 Jul 2015 16:13:39 +0800
Subject: [PATCH 2/5] genirq: irqdomain: Remove irqdomain dependency on
 struct device_node
In-Reply-To: <20150721175623.GA32187@red-moon>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com>
 <1437473280-11431-3-git-send-email-marc.zyngier@arm.com>
 <20150721175623.GA32187@red-moon>
Message-ID: <55AF50B3.5090804@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2015 01:56 AM, Lorenzo Pieralisi wrote:
> On Tue, Jul 21, 2015 at 11:07:57AM +0100, Marc Zyngier wrote:
>> struct device_node is very much DT specific, and the original authors
>> of the irqdomain subsystem recognized that tie, and went as far as
>> mentionning that this could be replaced by some "void *token",
>> should another firmware infrastructure be using it.
>
> Yes, that's similar to the problem Rafael solved with fwnode_handle,
> I do not know if we can extend the fwnode_handle to manage these
> generic tokens too, but the approach you have taken seem the right
> one to me (and you are doing this for components that are not really
> attached to struct device so I am not sure the fwnode_handle approach
> can be shoehorned to solve it).

If I understand correctly, fwnode_handle is not better , since
we need to update every caller of irqdomain functions as it's a new
type of pointer, that's will be the big change, void * is just fine.

Thanks
Hanjun
