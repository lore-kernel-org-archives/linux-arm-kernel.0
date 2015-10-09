From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 09 Oct 2015 21:24:00 +0100
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <56180F18.9010801@free.fr> (Mason's message of "Fri, 9 Oct 2015
 21:01:44 +0200")
References: <560EAA7C.3070302@free.fr> <5612A473.8030405@sigmadesigns.com>
 <5613EF4C.30603@sigmadesigns.com> <5898159.aPJzsGHAv7@wuerfel>
 <56180F18.9010801@free.fr>
Message-ID: <yw1xmvvriye7.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 09/10/2015 15:18, Arnd Bergmann wrote:
>> On Tuesday 06 October 2015 17:57:00 Marc Gonzalez wrote:
>>> This patch adds support for Sigma Designs "Tango4" platform, which is
>>> built around the ARM Cortex A9 MPCore (single and dual core SoCs).
>>>
>>> Tango4 is not to be confused with Tango3, which was built around a
>>> MIPS 74kf CPU.
>>>
>>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>> ---
>>> v3 changes: Updated clock tree DT (clk driver submitted)
>>>
>> 
>> Looks all reasonable to me now. Can I get an Ack from M?ns? It sounds
>> like he is the original author of the port.
>
> Arnd,
>
> It seems that Mans has a problem with my submission :-(
>
> I understand that there is some bad blood between him and Sigma.
> I also understand that Sigma's open source track record is below par.
>
> However, I think it needs to be pointed out that:
>
> 1) I don't speak for Sigma,

You've previously said that you do:
http://www.spinics.net/lists/arm-kernel/msg449191.html

> I merely work for them; and I always try to "do the right thing".
>
> 2) I accept valid technical criticism of my code, but Mans' points
> are sometimes clouded in a bit of hyperbole. (Especially wrt to the
> clk driver)

You keep insisting that your overly simplistic driver is smaller and
therefore better.  The truth is that the clock tree in these chips is
somewhat complex, and the right thing to do is to represent it as
accurately as possible.  If you do not, it will fail in some setup or
other, and this is not just a hypothetical.  Your clock driver gives the
wrong frequencies on my boards.

-- 
M?ns Rullg?rd
mans at mansr.com
