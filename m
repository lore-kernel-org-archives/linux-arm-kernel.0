From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 23 Feb 2016 21:12:25 +0100
Subject: [PATCH v1] arm: pxa: fix DT node name for PXA27X usb
In-Reply-To: <1456228901.23036.9.camel@gmail.com> (Sergei Ianovich's message
 of "Tue, 23 Feb 2016 15:01:41 +0300")
References: <1456139297-5854-1-git-send-email-ynvich@gmail.com>
 <87oab8wyfe.fsf@belgarion.home> <1456228901.23036.9.camel@gmail.com>
Message-ID: <87y4abuqxi.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Ianovich <ynvich@gmail.com> writes:

> Hi Robert,?
>
> On Mon, 2016-02-22 at 16:35 +0100, Robert Jarzmik wrote:
>> You're right, I haven't seen the pxa2xx.dtsi statement before.
>> 
>> As such, could you amend a bit your patch please to :
>> ?- add:
>> Fixes: 0ec1939668e5 ("ARM: dts: pxa: add the usb host controller")
>> ?- make the same change in pxa3xx.dtsi, as the same error is there
>> ?- and more globally align pxa2xx.dtsi, pxa27x.dtsi and pxa3xx.dtsi
>> ?- remove the compatible, reg, interrupts and status from both pxa27x.dtsi and
>> ???pxa3xx.dtsi as they are redundant with the included pxa2xxx.dsti one
>
> No problem. Let's figure out the best approach.
>
>> I'm even wondering if the proper change wouldn't be to scrap the ohci
>> declarations from pxa27x.dtsi and pxa3xx.dtsi, and only add the "clocks"
>> property to pxa2xx.dtsi ...
>
> Since clocks are declared in pxa27x.dtsi and?pxa3xx.dtsi, there is a
> stronger ground to have node clocks properties set in pxa27x.dtsi
> and?pxa3xx.dtsi as well. However, there is already nodes with clocks
> properties in pxa2xx.dtsi.
>
> I cannot choose, you should make a decision.
I have checked my manuals, and pxa25x doesn't have an USB Host controller.

So I'd rather have :
 - remove the usb0: ohci at 4c000000 node from pxa2xx.dtsi
 - add it completely to pxa27x.dtsi and pxa3xx.dtsi, with clocks and everything,
   in "disabled" status.

Cheers.

-- 
Robert
