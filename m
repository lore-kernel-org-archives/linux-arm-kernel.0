From: jenskuske@gmail.com (Jens Kuske)
Date: Sun, 1 Nov 2015 14:40:38 +0100
Subject: [PATCH v4 2/6] clk: sunxi: Add H3 clocks support
In-Reply-To: <3751073.AWmm18dvKK@wuerfel>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-3-git-send-email-jenskuske@gmail.com>
 <3751073.AWmm18dvKK@wuerfel>
Message-ID: <56361656.2040100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30/10/15 09:28, Arnd Bergmann wrote:
> On Tuesday 27 October 2015 17:50:22 Jens Kuske wrote:
>> +               of_property_read_string_index(node, "clock-output-names",
>> +                                             i, &clk_name);
>> +
>> +               if (index == 17 || (index >= 29 && index <= 31))
>> +                       clk_parent = AHB2;
>> +               else if (index <= 63 || index >= 128)
>> +                       clk_parent = AHB1;
>> +               else if (index >= 64 && index <= 95)
>> +                       clk_parent = APB1;
>> +               else if (index >= 96 && index <= 127)
>> +                       clk_parent = APB2;
>> +
>> +               clk_reg = reg + 4 * (index / 32);
>>
> 
> Same as for the reset driver, this probably means you should have one
> cell to indicate which bus it is for, and another cell for the
> index.
> 

This is what Maxime suggested in an earlier version:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/344213.html

In between I had another version with the parents in DT, but he
didn't like that too.

Jens
