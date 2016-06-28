From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Tue, 28 Jun 2016 18:27:34 +0200
Subject: [PATCH v2 04/14] regulator: SY8106A regulator driver
In-Reply-To: <20160627145400.GY28202@sirena.org.uk>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-5-megous@megous.com>
 <20160626112657.GK28202@sirena.org.uk>
 <3d6adff3-7ed3-73de-db0a-5f36c2f67a80@megous.com>
 <20160627145400.GY28202@sirena.org.uk>
Message-ID: <99d5e0d0-f2d6-d1c7-21fd-9b9c6edb76a2@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.6.2016 16:54, Mark Brown wrote:
> On Sun, Jun 26, 2016 at 05:07:16PM +0200, Ond?ej Jirman wrote:
>> On 26.6.2016 13:26, Mark Brown wrote:
> 
>>> I'm missing almost all of this series, I've just got this and another
>>> patch which look like a standalone driver so it's hard to see any
>>> dependencies.  What's going on here?
> 
>> Sorry, it's this series:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438981.html
> 
>> And here's v1 intro letter:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/438794.html
> 
> These aren't really enlightening I'm afraid, there's nothing in there
> about why these are a single series and no dependency information.
> Indeed it looks like something is really confused as the thread is
> missing at least patches 2 and 3.
> 

You're right there's not much about the regulator there. Xulong Orange
Pi PC is ARM SBC, that uses Allwinner H3 Soc, to which this regulator is
connected via I2C bus, to regulate the main CPU supply voltage. It is
used on some other SBC's from Xulong.

It is fairly simple single output, fixed I2C address voltage regulator.
It has just 3 registers, which allow for: slew rate control (not used in
this driver), setting and reading out the voltage, switching between
voltage set via I2C and via external resistor divider and
enabling/disabling output. It also has status reporting for
over-tempertature and over-current conditions. That's all the features
it has.

The patch series uses it to provide dynamic vltage scaling of the ARM
cores in the SoC to be able to achieve higher CPU frequency.

Datasheet is here:

https://01916271185794791722.googlegroups.com/attach/93415fbd5402/SY8106A_datasheet.pdf?part=0.1&vt=ANaJVrHMej8w8XRfd-7A3XoyiryMDDhrHU2SS-tYyHCpOIXRqIaICOIlZTWAUV74vToesmic457zPvODDuvrNnRpomPOPbtV8bMMFV65VX5aYb5NciMkh8E

I'll also include this information in the revised patch.

thank you and regards,
  Ondrej Jirman

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/e4ec00eb/attachment.sig>
