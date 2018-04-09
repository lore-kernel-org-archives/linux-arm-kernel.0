From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 9 Apr 2018 10:04:30 +0100
Subject: [PATCH v5 07/13] ARM: smp: Add initialization of CNTVOFF
In-Reply-To: <CAMuHMdUoUVF+WYrPG1Dx515_de_2nhGhLfn9+tJUm5jgs1uz0w@mail.gmail.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-8-mylene.josserand@bootlin.com>
 <06308f46-ce7c-ddeb-ebca-abd1153138ba@arm.com>
 <20180404155909.148085f7@dell-desktop.home>
 <86vad7qc21.wl-marc.zyngier@arm.com>
 <CAMuHMdUoUVF+WYrPG1Dx515_de_2nhGhLfn9+tJUm5jgs1uz0w@mail.gmail.com>
Message-ID: <bd94a149-267e-1089-7884-1bf0c7602c43@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/18 09:24, Geert Uytterhoeven wrote:
> On Wed, Apr 4, 2018 at 4:30 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On Wed, 04 Apr 2018 14:59:09 +0100,
>> Myl?ne Josserand wrote:
> 
> [Marc: stuck in ISO-8859-1? ;-]

I have no idea what Wanderlust does (that's what I use on my laptop).
But Thunderbird definitely interprets the original posting as '?', which
should work with a 8859-1. I need to have a look at how to get UTF-8 to
be the default... (I hate email clients).

> 
>>>> It'd be good to take this opportunity to refactor the shmobile code.
>>>
>>> I can do it in this series but I do not have any shmobile platforms so
>>> I will not be able to test my modifications (only compilation).
>>>
>>> If someone can test it for me (who?), it is okay for me to refactor this
>>> code :)
>>
>> I guess you could Cc the shmobile folks (Geert Uytterhoeven, Simon
>> Horman), and get them to review/test the changes.
> 
> Correct. I can test on a remote R-Car E2 ALT board that needs it.
> 
> P.S. Interestingly, none of the Renesas CA15 SoCs seem to suffer from it,
>      only CA7.

I suspect A15 has the courtesy of resetting CNTVOFF to zero, and A7
doesn't. But the letter of the architecture is that it has an "UNKNOWN
reset value".

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
