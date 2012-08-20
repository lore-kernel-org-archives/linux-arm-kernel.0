From: alanbutty12@gmail.com (Alan M Butler)
Date: Mon, 20 Aug 2012 18:37:32 +0100
Subject: [PATCH] ARM: Kirkwood: Iomega IX2-200 Device Tree Support Patch
 v2 Signed-off-by: Alan M Butler <alanbutty12@gmail.com>
In-Reply-To: <CADhrpJ7Fq0FktNN-54++39=SN_GrkX7gpse+2QfD7ioQw+_cEA@mail.gmail.com>
References: <cover.1345196553.git.alanbutty12@gmail.com>
 <05c3c186d3675cde472bcc3a01198b6726c48a3c.1345196553.git.alanbutty12@gmail.com>
 <20120819020607.GZ22226@titan.lakedaemon.net>
 <CADhrpJ5WX-ZR3vxwe92Rg4R9a1+79Vf-QxKdJhyaC87o8HJYrw@mail.gmail.com>
 <CADhrpJ6HmUd86zx6Az0bx9JiiYp6kMmTis6ARMWBrNqoK8aKng@mail.gmail.com>
 <CAOMZO5AZZwQS8rkvrG3Nd7KAhgh3+PcfkdoKiqRW95eaUyTghg@mail.gmail.com>
 <CADhrpJ7ZE=L25V8sKyQAT02iDuyCRwyCAjw4ukopek1i0TRqNw@mail.gmail.com>
 <CAOMZO5BoWyGzB3p11yE9NXAXq319oi0bnbFuwxvahCqGDOZKrw@mail.gmail.com>
 <CADhrpJ487cN23gRkws1Grp+SEmrKO2JdDT0r-DVeCZm-XqdP=A@mail.gmail.com>
 <CAOMZO5BbdT2CXHh4NEt8bPZ4C7Mg=Yd9C9E7J2H_JsGJ=88fqQ@mail.gmail.com>
 <CADhrpJ7Fq0FktNN-54++39=SN_GrkX7gpse+2QfD7ioQw+_cEA@mail.gmail.com>
Message-ID: <CADhrpJ56iWZnBKf6Knoqbm6iucrXMb7ESDtB8WSyWbCxO6A4rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 August 2012 13:44, Alan M Butler <alanbutty12@gmail.com> wrote:
> On 20 August 2012 13:36, Fabio Estevam <festevam@gmail.com> wrote:
>> On Mon, Aug 20, 2012 at 9:30 AM, Alan M Butler <alanbutty12@gmail.com> wrote:
>>
>>> im not sure but i only get that after applying the patch you sent me
>>> on the linux next from the 17th.
>>> i will try building a new linux-next later today and will send you what happens.
>>
>> Please do not drop the list from Cc.
>>
>>> would it be because i named the buttons power, reset and otb? instead
>>> of button at 1 and so on like the other kirkwood devices?
>>
>> I am not familiar with kirkwood device, sorry.
>
> sorry i forgot to cc the list.
>
> But as far as i can tell with the buttons the only difference between
> my device and the other's like the iconnect is that they named the
> buttons button at 1 and i named mine Power, Reset and OTB. Is it possible
> the capital letters are causing the problem?

i just tried your patch again with the latest linux-next dated 20th of
august with that patch you gave me and i am still getting the errors
on the gpio-keys this is the error:

[    4.838988] orion_gpio_is_valid: invalid GPIO 0
[    4.838999] orion_gpio_is_valid: invalid GPIO 0
[    4.839015] gpio-keys gpio-keys.2: Failed to request GPIO 0, error -22
[    4.845617] gpio-keys: probe of gpio-keys.2 failed with error -22

and this is how the keys are assigned in the dts file:

               Power {
                       label = "Power Button";
                       linux,code = <116>;
                       gpios = <&gpio0 14 1>;
               };
               Reset {
                       label = "Reset Button";
                       linux,code = <0x198>;
                       gpios = <&gpio0 12 1>;
               };
               OTB {
                       label = "OTB Button";
                       linux,code = <133>;
                       gpios = <&gpio1 3 1>;
               };

I hope this helps you figure out the problem.
