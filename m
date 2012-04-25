From: stigge@antcom.de (Roland Stigge)
Date: Wed, 25 Apr 2012 13:38:43 +0200
Subject: [PATCHv4 1/2] drivers: input: keypad: Add device tree support
In-Reply-To: <20120425105235.GV24211@n2100.arm.linux.org.uk>
References: <1335346004-18108-1-git-send-email-sourav.poddar@ti.com>
 <20120425105235.GV24211@n2100.arm.linux.org.uk>
Message-ID: <4F97E243.1040707@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell and Sourav,

On 04/25/2012 12:52 PM, Russell King - ARM Linux wrote:
> I think you and Roland Stigge need to put your heads together and come
> up with a common DT binding for matrix keypad devices, rather than
> inventing N different platform specific bindings.
> 
>> +Required Board Specific Properties, in addition to those specified by
>> +the shared matrix-keyboard bindings:
>> +- keypad,num-rows: Number of row lines connected to the keypad
>> +  controller.
>> +
>> +- keypad,num-columns: Number of column lines connected to the
>> +  keypad controller.

Right - the LPC32xx key scanner always has a square matrix design (#rows
== #cols), but I'm fine with re-using properties "keypad,num-rows" and
"keypad,num-columns" instead of "nxp,matrix-size".

Besides, I still have "nxp,debounce-delay-ms" and "nxp,scan-delay-ms" -
do I need to change this to some default properties I don't know of (yet)?

And: I re-used the DT subnodes strategy for the keycodes ("linux,code")
of the samsung-keypad driver, see
Documentation/devicetree/bindings/input/samsung-keypad.txt - can I
continue using it?

Thanks in advance,

Roland
