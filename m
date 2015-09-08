From: songjun.wu@atmel.com (Wu, Songjun)
Date: Tue, 8 Sep 2015 17:36:13 +0800
Subject: [PATCH 2/2] ASoC: atmel-classd: DT binding for Class D audio
 amplifier driver
In-Reply-To: <20150907162548.GW5313@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-3-git-send-email-songjun.wu@atmel.com>
 <20150903114316.GV12027@sirena.org.uk> <55EC0AFE.3080809@atmel.com>
 <20150907162548.GW5313@sirena.org.uk>
Message-ID: <55EEAC0D.7010003@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/8/2015 00:25, Mark Brown wrote:
> On Sun, Sep 06, 2015 at 05:44:30PM +0800, Wu, Songjun wrote:
>> On 9/3/2015 19:43, Mark Brown wrote:
>
>>> Why is this a separate DT node?  It seems that this IP is entirely self
>>> contained so I'm not clear why we need a separate node for the card, the
>>> card is usually a separate node because it ties together multiple
>>> different devices in the system but that's not the case here.
>
>> The classD can finish the audio function without other devices.
>> But I want to reuse the code in ASoC, leave many things(like creating PCM,
>> DMA operations) to ASoC, then the driver can only focus on how to configure
>> classD.
>> The classD IP is divided to tree parts logically, platform, CPU dai,
>> and codec, and these parts are registered to ASoC.
>
>> This separate DT node is needed in ASoC, ties these tree parts in ClassD.
>
> Sure, there's no problem at all having that structure in software but it
> should be possible to do this without having to represent this structure
> in DT.  It should be possible to register the card at the same time as
> the rest of the components rather than needing the separate device in
> the DT.
>
Do you mean using a single entry in the DT for the whole classD system 
and instantiate ASoC components from it.
For now, there are two entry, they could be combined to one entry.
