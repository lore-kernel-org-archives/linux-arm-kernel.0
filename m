From: aford173@gmail.com (Adam Ford)
Date: Tue, 12 Sep 2017 08:43:10 -0500
Subject: da850.dtsi Naming convention Question
Message-ID: <CAHCN7xJ7N6W2Pz1vsVV192V-s0g6q+ozvNBR21rx6LufJ4kR6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am confused by the naming convention of the da850.dtsi file, and I
am hoping someone can clarify how this works.

Specifically, is defined int he device tree as "gpio: gpio at 226000"

Other TI boards (like omap3.dtsi) use a convention with the address
after the @ symbol.

(in omap3.dtsi, the gpio bank1 is configured as gpio1: gpio at 48310000
where 48310000 is the address of the register)

An attempt was made to correct this in:

c2a3b4bca53a ("ARM: dts: davinci: use proper address after @")  where
an fix was made to make gpio: gpio at 1e26000  which would match the
address in the TRM.  Unfortunately, it looks as if it was undone
almost right away.

My question is this:  Where did the 226000 number originate, and why
would we not want to use the actual address of the 1e26000 as defined
in the Techincal Reference manual?

adam
