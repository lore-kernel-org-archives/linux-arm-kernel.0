From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Mon, 20 Oct 2014 16:02:41 -0500
Subject: [PATCHv2 2/2] ARM: dts: socfpga: Add a 3.3V fixed regulator node
In-Reply-To: <CAD=FV=XzQ0JHpNsu+fyuRGi6NHeVxwNdxuGTPny3+dbTDYCo5g@mail.gmail.com>
References: <1413819079-17120-1-git-send-email-dinguyen@opensource.altera.com>	<1413819079-17120-3-git-send-email-dinguyen@opensource.altera.com>
 <CAD=FV=XzQ0JHpNsu+fyuRGi6NHeVxwNdxuGTPny3+dbTDYCo5g@mail.gmail.com>
Message-ID: <54457871.404@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2014 10:51 AM, Doug Anderson wrote:
> Dinh,
> 
> On Mon, Oct 20, 2014 at 8:31 AM,  <dinguyen@opensource.altera.com> wrote:
>> +++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
>> @@ -37,6 +37,15 @@
>>                 */
>>                 ethernet0 = &gmac1;
>>         };
>> +
>> +       regulator_3_3v: regulator {
> 
> I think it's better to give this a real node name.  The
> "regulator_3_3v" will get dropped when you compile this into a binary
> format (for shipping), so you're creating a node that's just called
> "regulator".  If you had more than one fixed regulator like this it
> just won't work.
> 
> I haven't seen any official guidelines, but I tend to use "regulator"
> as a suffix and then put the schematic name.  Like:
> 
>   3_3v_regulator: 3-3-v-regulator
> 
>

Not sure if there's a limit on a node cannot start with numeric value?
But if I change it to your suggestion, the DTC does not compile:

Error: arch/arm/boot/dts/socfpga_cyclone5_socdk.dts:41.16-17 syntax error
FATAL ERROR: Unable to parse input tree


But regulator_3_3v: 3-3-v-regulator   will work fine.

Dinh
