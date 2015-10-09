From: slash.tmp@free.fr (Mason)
Date: Fri, 9 Oct 2015 23:12:31 +0200
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <yw1xmvvriye7.fsf@unicorn.mansr.com>
References: <560EAA7C.3070302@free.fr> <5612A473.8030405@sigmadesigns.com>
 <5613EF4C.30603@sigmadesigns.com> <5898159.aPJzsGHAv7@wuerfel>
 <56180F18.9010801@free.fr> <yw1xmvvriye7.fsf@unicorn.mansr.com>
Message-ID: <56182DBF.8000906@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2015 22:24, M?ns Rullg?rd wrote:

> Mason wrote:
> 
>> On 09/10/2015 15:18, Arnd Bergmann wrote:
>>> On Tuesday 06 October 2015 17:57:00 Marc Gonzalez wrote:
>>>> This patch adds support for Sigma Designs "Tango4" platform, which is
>>>> built around the ARM Cortex A9 MPCore (single and dual core SoCs).
>>>>
>>>> Tango4 is not to be confused with Tango3, which was built around a
>>>> MIPS 74kf CPU.
>>>>
>>>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>>> ---
>>>> v3 changes: Updated clock tree DT (clk driver submitted)
>>>>
>>>
>>> Looks all reasonable to me now. Can I get an Ack from M?ns? It sounds
>>> like he is the original author of the port.
>>
>> Arnd,
>>
>> It seems that Mans has a problem with my submission :-(
>>
>> I understand that there is some bad blood between him and Sigma.
>> I also understand that Sigma's open source track record is below par.
>>
>> However, I think it needs to be pointed out that:
>>
>> 1) I don't speak for Sigma,
> 
> You've previously said that you do:
> http://www.spinics.net/lists/arm-kernel/msg449191.html

"As far as the upstreaming process is concerned, I speak for Sigma."
means "Sigma allows me to handle the upstreaming process details."

"I don't speak for Sigma." means
"I am not responsible for Sigma's past (or present) business
decisions, as I have no influence on that process, apart from
requesting time for working on upstreaming."

>> I merely work for them; and I always try to "do the right thing".
>>
>> 2) I accept valid technical criticism of my code, but Mans' points
>> are sometimes clouded in a bit of hyperbole. (Especially wrt to the
>> clk driver)
> 
> You keep insisting that your overly simplistic driver is smaller and
> therefore better.  The truth is that the clock tree in these chips is
> somewhat complex, and the right thing to do is to represent it as
> accurately as possible.  If you do not, it will fail in some setup or
> other, and this is not just a hypothetical.  Your clock driver gives the
> wrong frequencies on my boards.

Let me get this straight.

You took my clk driver, labeled "Tango4 cpuclk driver", named clk-tango4.c,
which exports compatible "sigma,tango4-pll" and "sigma,tango4-cpuclk" and
which reads a register that doesn't exist on Tango3.

Then you took it for a spin on your Tango3 boards, and... would you look
at that! It doesn't even work.

Why don't you submit your clk driver for Tango3, and just let me finish
the Tango4 port? I have gone out of my way to send you a dev board and
some documentation, but now you just keep sniping at my work. Why?

EOT
