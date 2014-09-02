From: robherring2@gmail.com (Rob Herring)
Date: Tue, 2 Sep 2014 12:38:23 -0500
Subject: [RFC PATCH 1/1] drivers: introduce ARM SBSA generic UART driver
In-Reply-To: <3749748.k4a1nSHDdj@wuerfel>
References: <1409328803-1953-1-git-send-email-andre.przywara@arm.com>
 <540596A6.8000608@arm.com>
 <CAL_Jsq+Rs5MXC7s7EeWAEAPxxqaShAVGt=cdQxud5Us+-Zp6jw@mail.gmail.com>
 <3749748.k4a1nSHDdj@wuerfel>
Message-ID: <CAL_JsqKGbSd5BymnFhT8KBjbBCPO8wsrHhG9Qn20c7mrrxTDDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 2, 2014 at 8:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 02 September 2014 08:20:53 Rob Herring wrote:
>> >>
>> >> This alone is not okay. There is no such implementation of hardware.
>> >
>> > But the SBSA explicitly allows this. I don't know of any vendor who just
>> > implements the subset, but I've been told that this has been asked for.
>>
>> To use baudrate as an example, that must be configurable somehow
>> either with pl011 registers or in a vendor specific way. I suppose you
>> could do an actual implementation with all those things hardcoded in
>> the design, but that seems unlikely.
>
> Why does the baudrate need to be configurable? I think it's completely
> reasonable to specify a console port that has a fixed (as in the
> OS must not care) rate, and that can be implemented either as a UART
> with a programmable rate or as a set of registers that directly talks
> to a remote system management device over whatever hardware protocol
> they choose.

Sure. It is also completely reasonable that baudrate is configurable
and vendors can implement it however they choose since the SBSA does
not specify it. IIRC, the enabling and disabling bits are not
specified either.

Not having configurability is simply one variation on possible implementations.

Rob
