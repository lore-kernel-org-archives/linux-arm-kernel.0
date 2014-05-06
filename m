From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 May 2014 17:04:44 -0300
Subject: [PATCH v4 1/2] ARM: dts: imx51-eukrea-mbimxsd51-baseboard: Add
 CAN support
In-Reply-To: <1399404776.560722294@f389.i.mail.ru>
References: <1399404113-29207-1-git-send-email-fabio.estevam@freescale.com>
 <1399404776.560722294@f389.i.mail.ru>
Message-ID: <CAOMZO5DZFfC1NTF3gWGpCVwkOnzUi9npsLkPZioYrvDSKbFVGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 6, 2014 at 4:32 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
>> +     can0: can at 0 {
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&pinctrl_can>;
>> +             compatible = "microchip,mcp2515";
>> +             reg = <0>;
>> +             clocks = <&clk24M>;
>> +             spi-max-frequency = <1000000>;
>
> This should be of course 10000000, or removed completely
> since driver already applies such limitation to the SPI bus.
> I think Shawn can fix this during commit.

Yes, this should be 10MHz.

Thanks for the review.

Eric,

I forgot to Cc you on v4. Besides the 10MHz error above, does it look good?
