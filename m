From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Jul 2013 13:07:26 -0600
Subject: [PATCH v7 11/22] PCI: mvebu: Adapt to the new device tree layout
In-Reply-To: <20130709182026.GJ11908@titan.lakedaemon.net>
References: <1373388084-29520-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1373388084-29520-12-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130709182026.GJ11908@titan.lakedaemon.net>
Message-ID: <51DC5F6E.2080304@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2013 12:20 PM, Jason Cooper wrote:
> Bjorn,
> 
> On Tue, Jul 09, 2013 at 01:41:13PM -0300, Ezequiel Garcia wrote:
>> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>
>> The new device tree layout encodes the window's target ID and attribute
>> in the PCIe controller node's ranges property. This allows to parse
>> such entries to obtain such information and use the recently introduced
>> MBus API to create the windows, instead of using the current name based
>> scheme.
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  .../devicetree/bindings/pci/mvebu-pci.txt          | 145 ++++++++++++++++-----
>>  drivers/pci/host/pci-mvebu.c                       | 113 +++++++++++-----
>>  2 files changed, 193 insertions(+), 65 deletions(-)
> 
> After my conversation with tglx a few days ago [1], I'm even more
> inclined to push patches like this to the correct maintainers.  However,
> looking at how this patch fits into the series, it may be better if we
> take it through mvebu/arm-soc with your Ack.
> 
> It depends on the patches before it, and the patches after it depend on
> it.  Unless I'm reading this wrong, I would have a branch that you would
> pull and base this patch on, which I would then pull and base the rest
> of the series on. Reshuffling the series to alleviate this wouldn't work
> in this case. :-/

My experience has been:

The create-a-topic-branch-and-merge-it-multiple-places process is more
useful when you've got a series that does:

1) Create some new common infra-structure.
2) Something that uses the new infra-structure.

... and you expect that other patches will come along (or already exist)
that use the new common infra-structure too; we'll call those (3). This
applies especially when (2) and (3) will want to go in through different
trees.

Then, you'd typically create a topic branch for (1) above, and merge
that both wherever (2) and (3) will be applied.

For simpler cases, acks are much more common.
