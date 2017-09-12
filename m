From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 12 Sep 2017 19:29:09 +0530
Subject: da850.dtsi Naming convention Question
In-Reply-To: <CAHCN7xJ7N6W2Pz1vsVV192V-s0g6q+ozvNBR21rx6LufJ4kR6g@mail.gmail.com>
References: <CAHCN7xJ7N6W2Pz1vsVV192V-s0g6q+ozvNBR21rx6LufJ4kR6g@mail.gmail.com>
Message-ID: <d92f726f-8a84-14ac-571e-f405255fed0b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adam,

On Tuesday 12 September 2017 07:13 PM, Adam Ford wrote:
> I am confused by the naming convention of the da850.dtsi file, and I
> am hoping someone can clarify how this works.
> 
> Specifically, is defined int he device tree as "gpio: gpio at 226000"
> 
> Other TI boards (like omap3.dtsi) use a convention with the address
> after the @ symbol.
> 
> (in omap3.dtsi, the gpio bank1 is configured as gpio1: gpio at 48310000
> where 48310000 is the address of the register)
> 
> An attempt was made to correct this in:
> 
> c2a3b4bca53a ("ARM: dts: davinci: use proper address after @")  where
> an fix was made to make gpio: gpio at 1e26000  which would match the
> address in the TRM.  Unfortunately, it looks as if it was undone
> almost right away.

I think you are reading that commit in reverse. The fix was to make the
unit address match the reg property (make it gpio at 226000)

> 
> My question is this:  Where did the 226000 number originate, and why
> would we not want to use the actual address of the 1e26000 as defined
> in the Techincal Reference manual?

Because we define these nodes as being under the "soc" node at offset
1c00000.

Thanks,
Sekhar
