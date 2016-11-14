From: tomas.hlavacek@nic.cz (tomas.hlavacek at nic.cz)
Date: Mon, 14 Nov 2016 15:59:57 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161114131010.GC26710@lunn.ch>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <1479126185.15557.5@smtp.gmail.com> <20161114131010.GC26710@lunn.ch>
Message-ID: <1479135597.27133.2@smtp.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew!

(Sorry for re-posting the previous e-mail, that most likely didn't get 
through.)

On Mon, Nov 14, 2016 at 2:10 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>>  Actually SFP is connected to SGMII interface of eth1, which is
>>  routed through SERDES 5.
> 
> You say eth1 here. Yet lower down you say got eth0 and eth1 are
> connected to the switch?

Oh sorry, this was a NIC name based on probing order derived from base 
address of NIC registers:

	eth1: ethernet at 30000 - probes as eth0
	eth2: ethernet at 34000 - probes as eth1
	eth0: ethernet at 70000 - probes as eth2

It is a bit confusing. I meant eth2 in DTS. Sorry.

> 
> 
>>  We have our proprietary support hacked onto mvneta driver for
>>  disconnecting PHY on the fly. It is a bit nasty, so I suggest to
>>  ignore SFP in this DTS altogether and let's wait till "phylink based
>>  SFP module support" or something alike hits upstream, so we can base
>>  the SFP support on solid code;
> 
> It would be great if you could work on getting the phylink patches
> into mainline. It is something i have wanted to do for a long time,
> but it is too low down on my priority list to get to. The code is high
> quality, so i don't think there will be too many issues. It probably
> just needs splitting up into smaller batches, submitting, and working
> on any comments.

That is exactly what I thought when I saw the patches for the first 
time. I will try to merge the patches to the current kernel and see 
what happens. I still need to learn a lot about PHY subsystem.

> 
> 
>>  Actually eth0 and eth1 (both are RGMII) are connected to the 88E6176
>>  switch. The problem is that from what I have read so far the switch
>>  can not operate in DSA mode with two CPU ports.
> 
> Again, this is something i wanted to do, and i did have a prototype at
> one point. But again, not enough time. If you have resources to work
> on this, i can find my code, explain my ideas, and let you complete
> it.

I am definitely interested, though I didn't have time to read and 
absorb DSA yet, but I definitely want to try to hack 88E6176 support. I 
would be really grateful if you can provide some pointers and/or code 
to start from.

Thanks,
Tomas
