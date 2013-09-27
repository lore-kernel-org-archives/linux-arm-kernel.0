From: neko@bakuhatsu.net (Matt Sealey)
Date: Fri, 27 Sep 2013 14:48:16 -0500
Subject: device tree binding documentation outdated
In-Reply-To: <CAHCPf3vxGAzTnY360KC7Yt-DB1FB14Sv_Cn7DBTH6HGZ6y=stg@mail.gmail.com>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <20130926205906.GT12758@n2100.arm.linux.org.uk>
 <CAOMZO5Dj7o3qBH2hzPFWjepgpt5XR5qKmQorKS6jH_7=gnY5cg@mail.gmail.com>
 <20130927121357.GY12758@n2100.arm.linux.org.uk>
 <20130927132601.GL25146@S2101-09.ap.freescale.net>
 <20130927151900.GA12758@n2100.arm.linux.org.uk>
 <CAHCPf3t8=mJn-RCz3C1cY6zqsH9ds8UANKpKx9ZpwPM6WjJt3g@mail.gmail.com>
 <20130927174916.GD12758@n2100.arm.linux.org.uk>
 <CAHCPf3sC7bY=p4vpBQFpRUmyPspT_PVjx0rH9cm1ov=SqkO+Vg@mail.gmail.com>
 <20130927190546.GG12758@n2100.arm.linux.org.uk>
 <CAHCPf3vxGAzTnY360KC7Yt-DB1FB14Sv_Cn7DBTH6HGZ6y=stg@mail.gmail.com>
Message-ID: <CAHCPf3sv3wSbUc9QFVhmYsPc1kqiWYRuOMO7rreuiGSrwyepBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 2:41 PM, Matt Sealey <neko@bakuhatsu.net> wrote:
> On Fri, Sep 27, 2013 at 2:05 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> I've got good news... finally!
>>
> The difference would be
>
> * In the top situation, your PHY is generating the clock for the
> entire system - the i.MX6 takes it and uses it drive logic and to
> clock receive and sends it back out on TXC to transmit data (GPR1[21]
> = 0)
> * In the bottom situation, the i.MX6 generates a clock, the PHY uses
> it to drive it's logic AND generate other clocks, and the i.MX6 clock
> is looped back through the pad to the MAC to drive it's logic and
> clock transmit data (GPR1[21] = 1)

Ignore that. It's not totally wrong but it's weird. This is really
difficult to put into words...

GPR1[21] = 0 i.MX6 receives a clock from the PHY. You need to generate
a clock at the PHY as input to the MAC. The MAC won't run until the
PHY is out of reset and the clock is generated. You may need SION set
for RMII depending on the pin...
GPR1[21] = 1 implies we generate a clock from i.MX6 TO the PHY. The
clock is looped back through the pad to the MAC. SION is irrelevant.

Still want to know who's clock it is and where it should be going....
