From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 23 Jul 2018 10:44:23 +0100
Subject: [PATCH v4 02/20] virtio: pci-legacy: Validate queue pfn
In-Reply-To: <20180722185335-mutt-send-email-mst@kernel.org>
References: <1531905547-25478-1-git-send-email-suzuki.poulose@arm.com>
 <1531905547-25478-3-git-send-email-suzuki.poulose@arm.com>
 <20180722185335-mutt-send-email-mst@kernel.org>
Message-ID: <5a659490-13ce-87c1-a9bc-d89a8f8ee111@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2018 04:53 PM, Michael S. Tsirkin wrote:
> On Wed, Jul 18, 2018 at 10:18:45AM +0100, Suzuki K Poulose wrote:
>> Legacy PCI over virtio uses a 32bit PFN for the queue. If the
>> queue pfn is too large to fit in 32bits, which we could hit on
>> arm64 systems with 52bit physical addresses (even with 64K page
>> size), we simply miss out a proper link to the other side of
>> the queue.
>>
>> Add a check to validate the PFN, rather than silently breaking
>> the devices.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Cc: Peter Maydel <peter.maydell@linaro.org>
>> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>


Michael,

Thanks.

> 
> I assume this will be merged through some other tree.
>


As such these two virtio patches do not have any code dependencies with
the rest of the series. So, if you could pick this up it should be fine.
Otherwise, may be Marc can push it with the rest of the series.

Marc,

Are you OK with that ?

Suzuki
