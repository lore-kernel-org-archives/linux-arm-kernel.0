From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Thu, 13 Jul 2017 11:17:28 -0700
Subject: [PATCH v7 3/3] net/cxgb4: Use new
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
In-Reply-To: <CAKgT0UcBFBk9T7g0Dh-rHY6Z+6-4=5jsUWHbLcSMc+ohdTz=CA@mail.gmail.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-4-git-send-email-dingtianhong@huawei.com>
 <CAKgT0UcBFBk9T7g0Dh-rHY6Z+6-4=5jsUWHbLcSMc+ohdTz=CA@mail.gmail.com>
Message-ID: <CAKgT0Uf8Tg6AFthXt-bJrdNHCqJ3MfzduR1yCMMsjLYoEFXb-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 11:14 AM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Thu, Jul 13, 2017 at 7:21 AM, Ding Tianhong <dingtianhong@huawei.com> wrote:
>> From: Casey Leedom <leedom@chelsio.com>
>>
>> cxgb4 Ethernet driver now queries PCIe configuration space to determine
>> if it can send TLPs to it with the Relaxed Ordering Attribute set.
>>
>> Remove the enable_pcie_relaxed_ordering() to avoid enable PCIe Capability
>> Device Control[Relaxed Ordering Enable] at probe routine, to make sure
>> the driver will not send the Relaxed Ordering TLPs to the Root Complex which
>> could not deal the Relaxed Ordering TLPs.
>>
>> Signed-off-by: Casey Leedom <leedom@chelsio.com>
>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>
> Ding,
>
> You can probably just drop this patch. If I am understanding Casey
> correctly just the fact that the relaxed ordering enable bit is
> cleared in the configuration should be enough to do this for the
> device automatically.
>
> - Alex

Actually I take that back. I hadn't caught the most recent parts of
the thread. If this is good for Casey then this works for me.

- Alex
