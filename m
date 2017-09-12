From: aford173@gmail.com (Adam Ford)
Date: Tue, 12 Sep 2017 10:28:33 -0500
Subject: da850.dtsi Naming convention Question
In-Reply-To: <d92f726f-8a84-14ac-571e-f405255fed0b@ti.com>
References: <CAHCN7xJ7N6W2Pz1vsVV192V-s0g6q+ozvNBR21rx6LufJ4kR6g@mail.gmail.com>
 <d92f726f-8a84-14ac-571e-f405255fed0b@ti.com>
Message-ID: <CAHCN7xJosHuuPWUkr=ettc8gWgx9m6PvbFe90f2FnvT0meZVUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 12, 2017 at 8:59 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> Hi Adam,
>
> On Tuesday 12 September 2017 07:13 PM, Adam Ford wrote:
>> I am confused by the naming convention of the da850.dtsi file, and I
>> am hoping someone can clarify how this works.
>>
>> Specifically, is defined int he device tree as "gpio: gpio at 226000"
>>
>> Other TI boards (like omap3.dtsi) use a convention with the address
>> after the @ symbol.
>>
>> (in omap3.dtsi, the gpio bank1 is configured as gpio1: gpio at 48310000
>> where 48310000 is the address of the register)
>>
>> An attempt was made to correct this in:
>>
>> c2a3b4bca53a ("ARM: dts: davinci: use proper address after @")  where
>> an fix was made to make gpio: gpio at 1e26000  which would match the
>> address in the TRM.  Unfortunately, it looks as if it was undone
>> almost right away.
>
> I think you are reading that commit in reverse. The fix was to make the
> unit address match the reg property (make it gpio at 226000)
>

Thanks.  I typed the git diff instruction backwards.

>>
>> My question is this:  Where did the 226000 number originate, and why
>> would we not want to use the actual address of the 1e26000 as defined
>> in the Techincal Reference manual?
>
> Because we define these nodes as being under the "soc" node at offset
> 1c00000.
>

That makes a lot of sense, but I have a followup question.  Why would
we only have 1 gpio registered at 22600 when we have multiple banks?
Again, I am comparing this to the Omap3 because I have more experience
with that, and they register each bank separately.

The datasheet breaks it up into small banks, 0-1, 2-3, 4-5, 6-7 and 8
yet the device tree shows ti,ngpio = <144> and
ti,davinci-gpio-unbanked = <0>;

I only ask as I am trying to get more familiar with this platform, and
I am trying to enhance improve the da850-evm which I realize has been
replaced by the lcdk.

adam

> Thanks,
> Sekhar
