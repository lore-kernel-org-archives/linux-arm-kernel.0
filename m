From: npcomplete13@gmail.com (Vivek Unune)
Date: Wed, 15 Mar 2017 15:44:09 -0400
Subject: [PATCH] ARM: dts: BCM5301X: Add support for Linksys EA9500
In-Reply-To: <CAChtp75xk3LN1-DPVvaHT5qEvrdoFFvXEk-daVCcJ=4rYu_vmw@mail.gmail.com>
References: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
 <20170315185214.GF21021@lunn.ch>
 <CAChtp75xk3LN1-DPVvaHT5qEvrdoFFvXEk-daVCcJ=4rYu_vmw@mail.gmail.com>
Message-ID: <CAChtp75ncCG86u9CS=CC2C=a3BC7o1ZOxzdHp5mbhypsNLyCkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

I'm not entirely sure. But here is what I observed.
Bootloader sets up both the switches. And I can use all 8 ports of the
router when I boot Lede. Only the internal switch is detected and
configurable via swconfig tool
Internal switch is connected to CPU via port 5 same as Netgear R8000.
The other bit here is that I looked through the GPL source and gpio
pin 10 is labeled as EA9500_RST2LANSW_GPIO10_PIN/ResetSwitch. So when
I performed a robo reset of the pin and 5 ports (labeled 1 thru 5 on
the unit) of the 8 physical ports stopped working (no packets).

If the external switch were to be connect via dedicated ethernet
interface it should have shown up during the probe. Is in't it?
Unfortunately my understanding about network devices limits me to
investigate this further.

I'll be more than happy to perform any tests if needed.

Thanks,

Vivek

P.S  sorry for duplicate email if you did get this first time around.
I've turned off HTML formatting.


>
>
> On Wed, Mar 15, 2017 at 2:52 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>
>> Hi Vivek
>>
>> > - It has two switches in order to support 8 lan ports. Internal switch is
>> >   BCM53012. The external switch BCM53125 currently works as "dumb switch"
>>
>> Do you know how the second switch is connected? Is it cascaded off the
>> internal switch? Or does it have a dedicated Ethernet interface?
>>
>> Thanks
>>         Andrew
