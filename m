From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Thu, 24 Aug 2017 17:06:18 +0200
Subject: [GIT PULL] ARM: dts: aspeed: Changes for 4.14
In-Reply-To: <CAK8P3a1i0qJ+3Ty+QejDW5Pbyx24D9JjxrZuvhx8-1Hj2G1h1g@mail.gmail.com>
References: <CACPK8XerZV+3RbxofpghWioYC68kK531aQQ_Jc8ZYLrjjCUqjQ@mail.gmail.com>
 <CAK8P3a1i0qJ+3Ty+QejDW5Pbyx24D9JjxrZuvhx8-1Hj2G1h1g@mail.gmail.com>
Message-ID: <076266b4-175e-492f-0edf-543217efbce2@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2017 01:13 PM, Arnd Bergmann wrote:
> On Thu, Aug 24, 2017 at 6:14 AM, Joel Stanley <joel@jms.id.au> wrote:
>> Hi Arnd and Olof,
>> Aspeed devicetree updates for 4.14
>>
>>  - fix to expose the full flash windows on ast2400.
>>
> 
> Pulled into next/dt, thanks! Can you explain the CONFIG_VMSPLIT_2G
> requirement mentioned in the changelog here? Will it stop working with
> a normal multiplatform configuration that uses VMSPLIT_3G, or just
> have no effect?

The kernel will still boot but, without VMSPLIT_2G, the SPI flash 
controller driver will fail to map the memory windows of the flash 
devices. And the system will surely lack a root filesystem. 

C.
