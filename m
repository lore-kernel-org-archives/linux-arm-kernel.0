From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 13 Sep 2014 16:24:14 +0800
Subject: [PATCH v3 09/12] ARM: sunxi: dt: Add sample and output mmc clocks
In-Reply-To: <20140913081804.GY31276@lukather>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <1410466706-27386-10-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v676B=pbKDnAfb3yUdL1ORgbacNTo=5EsTauNo+H993Agw@mail.gmail.com>
 <20140913081804.GY31276@lukather>
Message-ID: <CAGb2v66KeidqMvYCt53F3aqTUAxziSR6dU1cuUyNbsZyN0Av+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 13, 2014 at 4:18 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Sep 12, 2014 at 06:23:02PM +0800, Chen-Yu Tsai wrote:
>> >                 mmc0: mmc at 01c0f000 {
>> >                         compatible = "allwinner,sun4i-a10-mmc";
>> >                         reg = <0x01c0f000 0x1000>;
>> > -                       clocks = <&ahb_gates 8>, <&mmc0_clk>;
>> > -                       clock-names = "ahb", "mmc";
>> > +                       clocks = <&ahb_gates 8>,
>> > +                                <&mmc0_clk>,
>> > +                                <&mmc0_sample_clk>,
>> > +                                <&mmc0_output_clk>;
>> > +                       clock-names = "ahb",
>> > +                                     "mmc",
>> > +                                     "sample",
>> > +                                     "output";
>>
>> Just a stylish nitpick. All the other resources in these files
>> are listed inline if possible, not one phandle/value per line.
>
> Look at the PIO interrupts, every USB PHY resources, etc. ;)

I guess we need some styling cleanups. :)

ChenYu
