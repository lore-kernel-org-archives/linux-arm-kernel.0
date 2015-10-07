From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Wed, 7 Oct 2015 07:06:52 +0300
Subject: [PATCH 0/3] ARM: dts: sun4i: USB DRC and voltage-scaling for
 pcDuino1/2
In-Reply-To: <20151005123848.GL2696@lukather>
References: <1443985128-23137-1-git-send-email-siarhei.siamashka@gmail.com>
 <20151005123848.GL2696@lukather>
Message-ID: <20151007070652.3ff06358@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Oct 2015 14:38:48 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Hi,
> 
> On Sun, Oct 04, 2015 at 09:58:45PM +0300, Siarhei Siamashka wrote:
> > Hello,
> > 
> > This brings LinkSprite pcDuino1/2 boards up to date with the latest
> > kernel features. And the first patch in this set is a bugfix for the
> > PH3/PH6 pins misuse.
> > 
> > There is currently a single dts file for pcDuino1 and pcDuino2 boards.
> > They obviously had been designed to be compatible with each other, but
> > have some minor differences, as can be seen when comparing schematics:
> >     https://s3.amazonaws.com/pcduino/Hardware/PC+Duino_V01-20130128.pdf
> >     https://s3.amazonaws.com/pcduino/Hardware/v2/pcDuino_v2_sch.pdf
> 
> Usually, the way we handle this is simply by including just the other
> DT that will only hold those differences.
> 
> What are those differences exactly ?

For the exact differences, one might look into the pdf schematics
files (that's why I have provided links). But a short summary is
the following:

* pcDuino1 has two USB host receptacles, but pcDuino2 has one USB host
  receptacle and a USB WIFI chip.
* There is this difference with the USB_EN pin (PD2), which controls
  a USB power switch in pcDuino2. There is no USB power switch in
  pcDuino1 and the PD2 pin is apparently only connected to a test
  point on the PCB.
* The SZQ resistor is different, which might mean different DDR3
  tracks routing.
* The Ethernet transceiver is different (RTL8201CP in pcDuino1 and
  IP101A_LF in pcDuino2).
* An extra LED is connected to the WIFI chip, but can't be accessed
  in any other way.

Other than the PD2 pin, nothing else seems to be really relevant
to the dts file. And even the PD2 pin is pulled-up in pcDuino2,
making the USB host port powered by default just like in pcDuino1.

-- 
Best regards,
Siarhei Siamashka
