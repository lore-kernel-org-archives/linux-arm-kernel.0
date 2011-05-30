From: christian.riesch@omicron.at (Christian Riesch)
Date: Mon, 30 May 2011 10:23:35 +0200
Subject: [PATCH V2] davinci: da850: move input frequency to board
	specific files
In-Reply-To: <BANLkTik2ouNyibS=_s=8t5yRFrEX+tF07A@mail.gmail.com>
References: <1306312622-4901-1-git-send-email-christian.riesch@omicron.at>
	<1306488053-27978-1-git-send-email-christian.riesch@omicron.at>
	<BANLkTik2ouNyibS=_s=8t5yRFrEX+tF07A@mail.gmail.com>
Message-ID: <95DC1AA8EC908B48939B72CF375AA5E3011CDD4483@alice.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From Menon, Nishanth [mailto:nm at ti.com]
> On Fri, May 27, 2011 at 02:20, Christian Riesch 
> <christian.riesch@omicron.at> wrote:
>> From: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
>>
>> Currently the input frequency of the SoC is hardcoded in the SoC
>> specific da850.c file to 24 MHz. Since the SoC accepts input
>> frequencies in a wide range from 12 to 50 MHz, boards with different
>> oscillator/crystal frequencies may be built.
>>
>> This patch allows setting a different input frequency in the board
>> specific files to support boards with oscillator/crystal frequencies
>> other than 24 MHz.
>Curious question: have you considered Documentation/power/opp.txt? Not
>entirely sure if that will help, but I am curious to know if there are
>reasons why it did not scale for you

I took a look at it but I got the impression that the code in mach-davinci does not use your OPP library. Instead the structs that are used for the OPPs are defined locally in arch/arm/mach-davinci/da850.c. The frequency multiplier and divider values are hardcoded there and do not scale with the input clock frequency.

Christian
