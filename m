From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 11 Aug 2014 19:31:16 +0200
Subject: [RESEND PATCH 2/2] ARM: dts: Add tps65090 FET constraints on
 Peach Pit and Pi
In-Reply-To: <20140811160222.GF17528@sirena.org.uk>
References: <1407757091-18730-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407757091-18730-2-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=XRmNkxXoxWaEfxFADrTgBrOPVX746woxiZoKck1ajwgA@mail.gmail.com>
 <20140811160222.GF17528@sirena.org.uk>
Message-ID: <53E8FDE4.40005@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 08/11/2014 06:02 PM, Mark Brown wrote:
> On Mon, Aug 11, 2014 at 08:57:24AM -0700, Doug Anderson wrote:
>> On Mon, Aug 11, 2014 at 4:38 AM, Javier Martinez Canillas
> 
>> > After the switch is turned on, a safety timer is started
>> > and before this timer times out the output voltage must
>> > have reached the input voltage. Otherwise the switch is
>> > turned off expecting an overload condition.
> 
>> > So using the maximum output voltage slew rate and the timer
>> > minimum and maximum timeouts, a voltage constraints can be
>> > expressed as bounded limits for the timeout. That is what
>> > is used in the board schematics and should be in the DT too.
> 
>> I don't understand this, but if you and Mark are happy with it...
> 
> I have not looked at this change to my knowledge.
> 

No worries, I have to re-spin anyways to fix the 17v typo that Doug pointed out.
But basically is related to our previous discussion in patch:

"[RFC 3/5] regulator: core: Only apply constraints if available on list voltage"

where you explained [0] to me that child regulators should explicit set their
constraints instead of getting from its parent supply. So this patch adds the
needed constraints for the children FETs even when their output voltage depend
on its parent supply.

>> ...I'm also not 100% certain what the above description has to do with
>> this change, but I'll admit to having only skimmed some of the earlier
>> conversations.
> 
> It's not at all clear to me either looking at the quoted section.
> 

Yes, the commit message is not great to say the least. Also I didn't have the
last version of the documentation so I misunderstood from where the constraints
mentioned in the schematics came from. Will fix the commit message when posting v2.

Thanks a lot and best regards,
Javier

[0]: https://lkml.org/lkml/2014/7/30/99
