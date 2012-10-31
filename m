From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 31 Oct 2012 04:22:11 -0400
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
 <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
 <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
 <20121029200032.GD30152@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
 <20121030123254.GD29095@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
 <20121030125419.GG29095@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
Message-ID: <CAORVsuWqoqrza-qrJskpMTj=2MW6JxNEhVzjWVXkM1mpqVO8cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 9:17 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 30 Oct 2012, Felipe Balbi wrote:
>
>> On Tue, Oct 30, 2012 at 12:50:52PM +0000, Paul Walmsley wrote:
>> > certainly PM-idle related, given that the problem goes away by reverting
>> > Jean's commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc "ARM: OMAP: convert
>> > I2C driver to PM QoS for MPU latency constraints".
>> >
>> > The problem is consistent and easy to reproduce here.
>>
>> I don't doubt that :-) What I think, however, is that PM QoS just made
I dont doubt either but cannot have it reproduced.

>> the problem a bit easier to trigger for whatever reason. Maybe because
>> pm qos defers constraint updates, or something similar ?
PM QoS just influences the cpuidle decision on the next power state of
the CPU and CORE power domains.

>
> Based on a very quick look, I'd say the original patch 3db11fe is broken.
> I don't see how it can ensure that its PM_QOS_CPU_DMA_LATENCY request is
> honored when CONFIG_CPU_IDLE=n. CONFIG_CPU_IDLE=n is the default for
> omap2plus_defconfig.
Withtout CPU_IDLE set the PM QoS has no influence on the power domains states.

>
>
> - Paul

Jean
