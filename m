From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Mar 2013 11:56:43 +0100
Subject: [GIT PULL] at91: fixes for 3.9-rc #2
In-Reply-To: <201303261022.39882.arnd@arndb.de>
References: <51517592.5010300@atmel.com> <201303261022.39882.arnd@arndb.de>
Message-ID: <51517EEB.7030709@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 11:22 AM, Arnd Bergmann :
> On Tuesday 26 March 2013, Nicolas Ferre wrote:
>> Another "fixes" pull-request for AT91 on top of material that you have already
>> taken. Fixes are manly typos but the bad node declaration and some misspelling
>> can cause confusion.
> 
> Hi Nicolas,
> 
> I'd prefer to take only fixes for serious bugs into 3.9 now, since I have
> already sent the fixes for -rc5. As far as I can tell, the macb node patch
> is the only one that falls into that category

Yes, fine, I stack them for 3.10 then.


> , but for that one, I'd
> prefer if it could be redone in a simpler way, by replacing
> 
> +       ahb {
> +               apb {
> +                       macb0: ethernet at f802c000 {
> +                               phy-mode = "rmii";
> +                               status = "okay";
> +                       };
> +               };
> +       };
> 
> 
> with
> 
> 	@macb0 {
> 		phy-mode = "rmii";
> 		status = "okay";
> 	}
> 
> as there is no need to provide the full path when you already have
> a label for the device.

Indeed, at first sight its looks like a nice solution. But I wonder if
we add several nodes in this kind of .dtsi files, we may end up with
mess between APB peripherals and board specific ones like leds, NAND, etc.
Moreover, the plain and full naming of the node makes it identifiable
without doubts, even someone not completely familiar with DT.

I slightly prefer to keep it like this, but I can still change my mind ;-)

Bye,
-- 
Nicolas Ferre
