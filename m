From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Sun, 12 Jun 2016 16:10:06 +0200
Subject: [PATCH 2/2] ARM: dts: utilite-pro: add mmc card slot support
In-Reply-To: <b6f3c46c5ae54abdab846effbed6c8fe@rwthex-s1-b.rwth-ad.de>
References: <20160612132046.1363-1-christopher.spinrath@rwth-aachen.de>
 <30f2c9e9b50d47d893218811f3223b3f@rwthex-s1-b.rwth-ad.de>
 <b6f3c46c5ae54abdab846effbed6c8fe@rwthex-s1-b.rwth-ad.de>
Message-ID: <acc71f8948b54994b692c805e8da5b46@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 06/12/2016 03:45 PM, Fabio Estevam wrote:
> On Sun, Jun 12, 2016 at 10:20 AM,  <christopher.spinrath@rwth-aachen.de> wrote:
> 
>> +&usdhc3 {
>> +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +       pinctrl-0 = <&pinctrl_usdhc3>;
>> +       pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
>> +       pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
>> +       no-1-8-v;
>> +       broken-cd;
> 
> A comment in the commit log as to why you use the 'broken-cd' property
> would be helpful.
> 
There are no card detection pins (until board revision 1.3; which seems
to be fairly new) and adding "broken-cd" was the only way to get card
detection working on my board. I will add this information to the commit
log.

Thanks,
Christopher

> Thanks
> 
