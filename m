From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Oct 2015 10:29:29 -0500
Subject: [RFC/PATCH 11/11] arm: boot: dts: omap: add missing default
 status for 32k counter
In-Reply-To: <20151006151805.GR23801@atomide.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <20151005175230.GG18784@saruman.tx.rr.com> <87io6lf6i4.fsf@saruman.tx.rr.com>
 <13543270.oBfHhoNL28@wuerfel> <87612k3uza.fsf@saruman.tx.rr.com>
 <20151006151805.GR23801@atomide.com>
Message-ID: <87oagc2exy.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Tony Lindgren <tony@atomide.com> writes:

> * Felipe Balbi <balbi@ti.com> [151006 08:02]:
>> - ti,timer-alwon:	Indicates the timer is in an alway-on power
>>   domain.
>> 
>> Tony, care to comment if we should add timer-alwon to 32k ?
>
> No that should not be needed for the 32k counter. We should be able
> to do everything we want with CLOCK_SOURCE_SUSPEND_NONSTOP for the
> 32k counter.
>
> We still need ti,timer-alwon for a while for gptimers 1 and 12 as
> they are the only ones in the always-on domain. I guess that need
> will eventually go away too once we have a proper interconnect
> driver and are using genpd.

cool, thanks. I'll try to respin this series, hopefully still this week.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/3be09424/attachment.sig>
