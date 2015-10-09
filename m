From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 09 Oct 2015 15:40:39 +0100
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <5898159.aPJzsGHAv7@wuerfel> (Arnd Bergmann's message of "Fri, 09
 Oct 2015 15:18:15 +0200")
References: <560EAA7C.3070302@free.fr> <5612A473.8030405@sigmadesigns.com>
 <5613EF4C.30603@sigmadesigns.com> <5898159.aPJzsGHAv7@wuerfel>
Message-ID: <yw1xbnc8jeag.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday 06 October 2015 17:57:00 Marc Gonzalez wrote:
>> This patch adds support for Sigma Designs "Tango4" platform, which is
>> built around the ARM Cortex A9 MPCore (single and dual core SoCs).
>> 
>> Tango4 is not to be confused with Tango3, which was built around a
>> MIPS 74kf CPU.
>> 
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>> v3 changes: Updated clock tree DT (clk driver submitted)
>> 
>
> Looks all reasonable to me now. Can I get an Ack from M?ns? It sounds
> like he is the original author of the port.

NAK.  The clock parts are a complete shambles (compare to the patch I
sent earlier today), and the rest has a bunch of pointless and
misleading changes compared to my code.  This version won't work
correctly even on the SMP8759 hardware I have, let alone on the older
members of the chip family.  My code does.

The reason I haven't posted my patches is that I'm still working them
(albeit slowly), and I don't yet consider the code fit for upstreaming.

I've tried to work nicely with Sigma on this, but that's proving
difficult.  The patches posted so far by Marc seem to me like nothing
but poor NIH rewrites of my code.

-- 
M?ns Rullg?rd
mans at mansr.com
