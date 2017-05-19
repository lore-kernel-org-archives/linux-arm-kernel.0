From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 20 May 2017 02:06:57 +0800
Subject: [RFC PATCH 01/11] dt-bindings: update the binding for Allwinner
 H3 TVE support
In-Reply-To: <20170519180215.7lc7duueu74pt4kz@flea.home>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <20170517164354.16399-2-icenowy@aosc.io>
 <20170519180215.7lc7duueu74pt4kz@flea.home>
Message-ID: <ED64A56C-4FD3-4878-B67E-1501F20C7B8D@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?5?20? GMT+08:00 ??2:02:15, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>On Thu, May 18, 2017 at 12:43:44AM +0800, Icenowy Zheng wrote:
>> -On SoCs other than the A33 and V3s, there is one more clock
>required:
>> +For the following compatibles:
>> +   * allwinner,sun5i-a13-tcon
>> +   * allwinner,sun6i-a31-tcon
>> +   * allwinner,sun6i-a31s-tcon
>> +   * allwinner,sun8i-a33-tcon
>> +   * allwinner,sun8i-v3s-tcon
>> +there is one more clock and one more property required:
>> + - clocks:
>> +   - 'tcon-ch0': The clock driving the TCON channel 0
>> + - clock-output-names: Name of the pixel clock created
>> +
>> +For the following compatibles:
>> +   * allwinner,sun5i-a13-tcon
>> +   * allwinner,sun6i-a31-tcon
>> +   * allwinner,sun6i-a31s-tcon
>> +   * allwinner,sun8i-h3-tcon0
>> +there is one more clock required:
>>     - 'tcon-ch1': The clock driving the TCON channel 1
>
>Putting ID's in the compatible name is usually a bad idea. What is the
>difference between the two? Only that the second one doesn't have a
>clock?

Yes.

>
>That seems highly unlikely. How does it generate the pixel clock
>frequency?

Yes it seems impossible, but it's also the fact.

There's only one CLK_TCON in H3/5, which is for TCON0.

It's possible that lcd-ch1 clk is CLK_TVE, but it's still a weird situation --
Although we have a lcd-ch1 clock, we cannot touch it, otherwise
the TVE will refuse to work (the TVE can only work under 216MHz).

>
>Maxime
