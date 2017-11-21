From: sebastien.bourdelin@savoirfairelinux.com (Sebastien Bourdelin)
Date: Tue, 21 Nov 2017 10:37:39 -0500
Subject: [PATCH 2/2] ARM: dts: TS-7970: add basic device tree
In-Reply-To: <CAOMZO5AFEqk6FcfzJGO6VH0LpF7uFnkmiMYds9y=jajx8ygdZQ@mail.gmail.com>
References: <20171120211557.27946-1-sebastien.bourdelin@savoirfairelinux.com>
 <20171120211557.27946-2-sebastien.bourdelin@savoirfairelinux.com>
 <CAOMZO5AFEqk6FcfzJGO6VH0LpF7uFnkmiMYds9y=jajx8ygdZQ@mail.gmail.com>
Message-ID: <9f24aabd-bf1f-c48f-b997-b0c80e44ca81@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 11/20/2017 06:37 PM, Fabio Estevam wrote:
> Hi Sebastien,
> 
> On Mon, Nov 20, 2017 at 7:15 PM, Sebastien Bourdelin
> <sebastien.bourdelin@savoirfairelinux.com> wrote:
> 
>> +&ecspi2 {
>> +       cs-gpios = <
>> +               &gpio5 31 GPIO_ACTIVE_HIGH
>> +               &gpio7 12 GPIO_ACTIVE_HIGH
>> +               &gpio5 18 GPIO_ACTIVE_HIGH
>> +       >;
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_ecspi2>;
>> +       status = "okay";
>> +
>> +       spidevfpga: spi at 1 {
>> +               compatible = "spidev";
>> +               reg = <1>;
>> +               spi-max-frequency = <1000000>;
> 
> According to drivers/spi/spidev.c:
> 
> /*
> * spidev should never be referenced in DT without a specific
> * compatible string, it is a Linux implementation thing
> * rather than a description of the hardware.
> */
> 

Thanks, you are right!
Just to point it, this warning has been introduced in
956b200a846e324322f6211034c734c65a38e550 in date of march 2015, and it
seems some devices trees whom had been introduced after still use the
"spidev" string only.
