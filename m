From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 31 Oct 2012 11:49:58 +0100
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <CAORVsuWqoqrza-qrJskpMTj=2MW6JxNEhVzjWVXkM1mpqVO8cQ@mail.gmail.com>
 (Jean Pihet's message of "Wed, 31 Oct 2012 04:22:11 -0400")
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
 <CAORVsuWqoqrza-qrJskpMTj=2MW6JxNEhVzjWVXkM1mpqVO8cQ@mail.gmail.com>
Message-ID: <87fw4u3oh5.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

Jean Pihet <jean.pihet@newoldbits.com> writes:

[...]

>> Based on a very quick look, I'd say the original patch 3db11fe is broken.
>> I don't see how it can ensure that its PM_QOS_CPU_DMA_LATENCY request is
>> honored when CONFIG_CPU_IDLE=n. CONFIG_CPU_IDLE=n is the default for
>> omap2plus_defconfig.
>
> Withtout CPU_IDLE set the PM QoS has no influence on the power domains states.

Exactly, which means there is *no* constraint set when CPUidle is
disabled, and it's exactly this that is different from the behavior
before your patch.

Before your patch, the constraint would be set whether or not CPUidle
was enabled, correct?

The solution to this will probably be to make OMAPs non-CPUidle idle path
check the constraints.

Kevin
