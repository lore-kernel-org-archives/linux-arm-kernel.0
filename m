From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 10 Dec 2012 21:47:55 +0000
Subject: [PATCH 1/2] arm: mvebu: add RTC support for Armada 370 and Armada
 XP
In-Reply-To: <20121210162819.46fe4f91@skate>
References: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
 <1355136122-30729-2-git-send-email-gregory.clement@free-electrons.com>
 <20121210162819.46fe4f91@skate>
Message-ID: <20121210214755.9CD823E0C7C@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Dec 2012 16:28:19 +0100, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> Dear Gregory CLEMENT,
> 
> On Mon, 10 Dec 2012 11:42:01 +0100, Gregory CLEMENT wrote:
> 
> > +		rtc at 10300 {
> > +			compatible = "marvell,orion-rtc";
> > +			reg = <0xd0010300 0x20>;
> > +			interrupts = <50>;
> > +		};
> 
> Maybe an explicit status = "okay" here?

Only necessary if it is typical for the device to get disabled. I don't
add status="okay" properties unless it is to enable a device previously
disabled with status="disabled"

g.
