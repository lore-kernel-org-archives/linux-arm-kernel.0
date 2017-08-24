From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Aug 2017 23:24:28 +0200
Subject: [GIT PULL] ARM: dts: aspeed: Changes for 4.14
In-Reply-To: <076266b4-175e-492f-0edf-543217efbce2@kaod.org>
References: <CACPK8XerZV+3RbxofpghWioYC68kK531aQQ_Jc8ZYLrjjCUqjQ@mail.gmail.com>
 <CAK8P3a1i0qJ+3Ty+QejDW5Pbyx24D9JjxrZuvhx8-1Hj2G1h1g@mail.gmail.com>
 <076266b4-175e-492f-0edf-543217efbce2@kaod.org>
Message-ID: <CAK8P3a1eQq+fkAT7jkpzHk0arCtVENJzGxk3s7aRLzU5v86xzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 5:06 PM, C?dric Le Goater <clg@kaod.org> wrote:
> On 08/24/2017 01:13 PM, Arnd Bergmann wrote:
>> On Thu, Aug 24, 2017 at 6:14 AM, Joel Stanley <joel@jms.id.au> wrote:
>>> Hi Arnd and Olof,
>>> Aspeed devicetree updates for 4.14
>>>
>>>  - fix to expose the full flash windows on ast2400.
>>>
>>
>> Pulled into next/dt, thanks! Can you explain the CONFIG_VMSPLIT_2G
>> requirement mentioned in the changelog here? Will it stop working with
>> a normal multiplatform configuration that uses VMSPLIT_3G, or just
>> have no effect?
>
> The kernel will still boot but, without VMSPLIT_2G, the SPI flash
> controller driver will fail to map the memory windows of the flash
> devices. And the system will surely lack a root filesystem.

Hmm, why does the flash controller even map the entire area?

IIRC, NOR flash controllers normally have a 'ranges' property that
gets set up to list the available memory ranges, and the chips
attached to them have the 'reg' property that matches the actual
size.

     Arnd
