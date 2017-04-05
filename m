From: john.garry@huawei.com (John Garry)
Date: Wed, 5 Apr 2017 14:05:30 +0100
Subject: [PATCH net-next 1/4] ixgbe: sparc: rename the
 ARCH_WANT_RELAX_ORDER to IXGBE_ALLOW_RELAXED_ORDER
In-Reply-To: <819bc6c1-581b-3ab9-d189-1befaaf43548@huawei.com>
References: <1491031554-19516-1-git-send-email-dingtianhong@huawei.com>
 <1491031554-19516-2-git-send-email-dingtianhong@huawei.com>
 <20170401.112603.1991545644693496714.davem@davemloft.net>
 <819bc6c1-581b-3ab9-d189-1befaaf43548@huawei.com>
Message-ID: <118dee30-69a8-4ee0-791d-a46d268af3b4@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2017 07:49, Ding Tianhong wrote:
>
>
> On 2017/4/2 2:26, David Miller wrote:
>> From: Ding Tianhong <dingtianhong@huawei.com>
>> Date: Sat, 1 Apr 2017 15:25:51 +0800
>>
>>> Till now only the Intel ixgbe could support enable
>>> Relaxed ordering in the drivers for special architecture,
>>> but the ARCH_WANT_RELAX_ORDER is looks like a general name
>>> for all arch, so rename to a specific name for intel
>>> card looks more appropriate.
>>>
>>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>>
>> This is not a driver specific facility.
>>
>> Any driver can test this symbol and act accordingly.
>>
>> Just because IXGBE is the first and only user, doesn't mean
>> the facility is driver specific.
>>
>
> Understand clearly?but the ARCH_WANT_RELAX_ORDER is really too generic and simple,
> cause much misleading to indicate that it looks like the hack code for some architecture.
> what do you think of the ETHERNET_ALLOW_RELAXED_ORDER in the drivers/net/ethernet/*,
> it will only affect ethernet and not only for Ixgbe.
>

Hi Ding,

I think the actual original config ARCH_WANT_RELAX_ORDER is quite 
dubious, and it does not really tell us which feature(s) of the 
architecture supports this (if indeed it is arch specific).

According to the original commit, 1a8b6d76dc5b net:add one common config 
ARCH_WANT_RELAX_ORDER to support relax ordering, this is specific to 
SPARC only:
"Currently it only supports one special cpu architecture(SPARC) in 82599 
driver to enable RO feature, this is not very common for other cpu 
architecture which really needs RO feature".

This sounds wooly.

So I think that we need to know which specific architecture, memory 
model, or PCI host/port/EP features, or combination of them, allows this 
so called relaxed ordering.

And a config option is probably not even the proper check.

John

> Thanks
> Ding
>
>
>> Thank you.
>>
>> .
>>
>
>
> .
>
