From: c.aeschlimann@acn-group.ch (Christophe Aeschlimann)
Date: Mon, 21 Mar 2011 13:15:37 +0100
Subject: ALSA issue on DA850/OMAP-L138/AM18x
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870370B2BA32@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>	<4D5BDA3D.5080905@acn-group.ch>	<B85A65D85D7EB246BE421B3FB0FBB593024B83B5E4@dbde02.ent.ti.com>	<4D749A09.8050101@acn-group.ch>	<B85A65D85D7EB246BE421B3FB0FBB593024C0E5EC7@dbde02.ent.ti.com>	<4D762FEB.3010003@acn-group.ch>
	<4D870A59.9050004@acn-group.ch>
	<FCCFB4CDC6E5564B9182F639FC3560870370B2BA32@dbde02.ent.ti.com>
Message-ID: <4D874169.9010202@acn-group.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.03.2011 12:24, Bedia, Vaibhav wrote:
> On Monday, March 21, 2011 1:51 PM, Christophe Aeschlimann wrote:
> [...]
>> In this end it was a HW issue.
>>
>> Problem solved.
>>
> 
> If you don't mind, can you please elaborate on what the h/w issue was and how you fixed it?
> 
> Regards,
> Vaibhav

The symptoms were slightly different on our custom board which uses a
TLV320AIC3107 codec :

After every cold boot the system would take ~7 seconds to start
recording. Recording a second time just after the first time would
behave normally (without delay).

This delay was because the ADC (audio input) starts working when the
volts reach 1.35V (common mode) on the ADC. But a 10uF series capacitor
was delaying the ramp-up by 7 seconds. Reducing the capacitor size
changed the delay to something more reasonable (ms range).

This "issue" is described in the TLV320AIC3107 codec under "INPUT
IMPEDANCE AND VCM CONTROL" the 2nd paragraph. (they also offer a
workaround but this was not of a practical use in our case).

Hope this helps.

Regards,


-- 
Christophe Aeschlimann

Embedded Software Engineer & IT Manager

ACN Advanced Communications Networks S.A.

Rue du Puits-Godet 8a
2000 Neuch?tel, Switzerland

T?l. +41 32 724 74 31

c.aeschlimann at acn-group.ch
