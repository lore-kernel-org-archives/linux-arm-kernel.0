From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 12 May 2015 08:20:52 +0200
Subject: [PATCH v3 1/4] ARM: pxa: add memory resource to RTC device
In-Reply-To: <CAL_Jsq+tNStipTDRH05XRHVDz30B8w92YTD1ZKUTrCp-Lj7=1w@mail.gmail.com>
 (Rob Herring's message of "Mon, 11 May 2015 19:35:24 -0500")
References: <1431384089-28367-1-git-send-email-robh@kernel.org>
 <1431384089-28367-2-git-send-email-robh@kernel.org>
 <20150511224934.GL2067@n2100.arm.linux.org.uk>
 <CAL_Jsq+tNStipTDRH05XRHVDz30B8w92YTD1ZKUTrCp-Lj7=1w@mail.gmail.com>
Message-ID: <87lhgumi4b.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

>> This really isn't a good idea - what do you think happens when
>> the same struct resource gets passed into insert_resource()
>> twice?
>
> Bad things. If you recall, we discussed this on v1[1]. See the commit
> msg of patch 2 for the summary. There is not currently a problem
> because the rtc-pxa driver does not request the resource.

I think you're talking about resource claiming, while Russell is talking about
resource declaration.

The point Russell is raising is if you do a platform_add_device() twice with the
same resource (which is done in pxa, once for sa1100-rtc, once for pxa-rtc), you
call insert_resource() twice with the same resource structure.

I had not thought of that before (that's in my reply noted "nasty consequences"
in [1]), and I'll do my homework this week, and try this only patch, but if I
follow Russell's thinking, then sa1100-rtc and pxa-rtc cannot be declared
together anymore.

Cheers.

--
Robert
