From: klightspeed@killerwolves.net (Ben Peddell)
Date: Mon, 17 Nov 2014 09:23:13 +1000
Subject: [PATCHv1 2/3] arm: mvebu: add .dts file for Synology DS213j
In-Reply-To: <87d28nb83u.fsf@natisbad.org>
References: <cover.1416095841.git.arno@natisbad.org>	<1eb26f8c1946622910a7e2318c895a7082fea7e5.1416095841.git.arno@natisbad.org>	<20141116020024.GC15870@lunn.ch>
 <87d28nb83u.fsf@natisbad.org>
Message-ID: <546931E1.5070909@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/11/2014 11:14 PM, Arnaud Ebalard wrote:
>>> +	gpio-fan-100-32-35 {
>> There is some logic to this naming, but i don't remember what it is.
>> Did you check this is appropriate?
> The 32-35 is for the MPP i.e. fan uses mpp32 to mpp35 (3 MPP for speed,
> one for alarm). I don't know what the 100 part means. What I did is I
> googled to see which fan supported kirkwood models have and noticed
> that the DS212j uses the exact same fan, i.e. Y.S.Tech FD129225LL-N so
> I opted for the same naming.
>
> On that aspect, you may be able to explain why the speed-map for this
> fan goes up to 5000 RPM. This fan is supposed to operate at 1900RPM.
> Note that it does not matter in practice.

On the Kirkwood Diskstations, the first number (100, 120 or 150) refers
to the middle of the three fan speed resistors, the second number (15 or
32) refers to the first fan control pin, and the third number (18 or 35)
refers to the first fan alarm pin.

i.e. the 100-32-35 uses fan speed resistors of 33, 100 and 150 ohms,
uses pins 32-34 for fan control, and uses pin 35 for the fan alarm.

The 5000RPM was interpolated from my measured RPM pulse rate (4200PPM)
of the 80mm fan in my DS211j (which uses the 150-32-35 fan config) at
maximum RPM.

-- 
Ben Peddell
 * ICT - School Support Officer
   - St Mary's School Bowen
   - St Catherine's School Proserpine
   - St John Bosco's School Collinsville
 * Mobile: 0431 800 195

*** Disclaimer ***
This email is only for the addressees, so please don't disclose it
to others without prior agreement.  The opinions expressed are mine,
and not my employer's.  My employer shall not be liable.  I am not
a lawyer.  I check my attachments for viruses, but I can't guarantee
my email will arrive unaltered.

#include "http://klightspeed.killerwolves.net/stddisclaimer.txt"
