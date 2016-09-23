From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 23 Sep 2016 22:01:47 +0200
Subject: [PATCH 2/3] firmware: dt: document lpc1850 boot ROM bindings
In-Reply-To: <20160923133949.GA24505@rob-hp-laptop>
References: <20160913195117.2887-1-manabian@gmail.com>
 <20160913195117.2887-3-manabian@gmail.com>
 <20160923133949.GA24505@rob-hp-laptop>
Message-ID: <CAGhQ9VwLHiONa5pfpAhKuu78uDwYRjfwJu3i1fhjVz+zaDFojw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 September 2016 at 15:39, Rob Herring <robh@kernel.org> wrote:
> On Tue, Sep 13, 2016 at 09:51:16PM +0200, Joachim Eastwood wrote:
>> Binding documentation for the NXP LPC boot ROM.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>>  .../devicetree/bindings/firmware/nxp,boot-rom.txt   | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/firmware/nxp,boot-rom.txt
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/nxp,boot-rom.txt b/Documentation/devicetree/bindings/firmware/nxp,boot-rom.txt
>> new file mode 100644
>> index 0000000..5f3a044
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/firmware/nxp,boot-rom.txt
>> @@ -0,0 +1,21 @@
>> +* NXP LPC boot ROM
>> +
>> +NXP LPC microcontrollers contains a boot ROM used to retrieve part information
>> +and access internal Flash memory and OTP memory. Note that the Flash API is
>> +not available on Flashless devices.
>
> Is this determined at run-time? If not flashless devices should have a
> different compatible string to determine this then.

It is determined at run time by reading a 'CHIP ID' register in CREG
(syscon) that is present on both Flash and Flashless devices.


regards,
Joachim Eastwood
