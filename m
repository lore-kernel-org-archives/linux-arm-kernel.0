From: benoitm@perenite.com (Benoit Masson)
Date: Sat, 28 Nov 2015 21:32:29 +0100
Subject: [PATCH 1/4] ARM: dt: mvebu: ix4-300d: remove whole flash partition
In-Reply-To: <5659E687.9090502@gmail.com>
References: <1448709248-21177-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1448709248-21177-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20151128165258.GG32356@lunn.ch> <5659E687.9090502@gmail.com>
Message-ID: <6257884654271000421@unknownmsgid>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From mobile

> Le 28 nov. 2015 ? 18:38, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> a ?crit :
>
>> On 28.11.2015 17:52, Andrew Lunn wrote:
>>> On Sat, Nov 28, 2015 at 12:14:05PM +0100, Sebastian Hesselbarth wrote:
>>> Current NAND node has an additional flash partition for the whole
>>> flash overlapping with real partitions. Remove this partition as
>>> the whole flash is already represented by the NAND device itself.
>>
>> If i remember correctly, we discussed this when the contribution was
>> made. I think the stock firmware might use this for applying updates.
>> Maybe Benoit can comment?
>
> Yes, please.
>From my memory since I'm not running the stock firmware it uses the
MTD device directly. This is safe to remove. I was not very contort
able with this flash dts part it was copied over from a netgear mevbu
device ...

>
>> If so, removing this will break compatibility with stock firmware. Do
>> we want to do that? There are a few other mvebu dts files with a
>> partition spanning the whole flash. Should we remove them as well?
>
> Well, there is already a mtd device that spans the whole flash so
> what is the purpose of another "partition" that isn't a part but
> all of the device? Actually, I doubt that a FW update will wipe
> the flash as a whole, i.e. including boot loader, boot env, user
> config.
>
> Anyway, let's see if Benoit can shed some light on this.
>
> FWIW, neither single partitions nor a combined partitions node
> should be a direct sub-node of the _controller_ but a NAND
> _device_ node instead. Luckily, multi-device systems are not that
> common, so I guess we wait with it until such a system pops up for
> testing.
>
> Sebastian
>
>
