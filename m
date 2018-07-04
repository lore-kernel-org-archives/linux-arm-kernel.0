From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 4 Jul 2018 21:52:38 +0200
Subject: droid 4: connection refused from voltage_now
In-Reply-To: <20180704194556.GA9189@lenoch>
References: <20180704171156.GA3158@amd>
 <20180704194556.GA9189@lenoch>
Message-ID: <20180704195238.GA13932@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-07-04 21:45:56, Ladislav Michl wrote:
> On Wed, Jul 04, 2018 at 07:11:56PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > I started to use droid 4 as my primary phone... so I have battery
> > monitor running for hours... Once every few days it dies with
> > "connection refused" error reading battery's "voltage_now". I restart
> > it and it continues working...
> 
> Ha! What exactly that "connection refused" means? Is it ECONNREFUSED (111)?
> I have custom at91 based board here with few custom power supply drivers
> and it sometimes ends with voltage_now of my driver being unreadable.
> (I modified userspace code and waiting what's in errno in case
> reading fails)

It seems to be -110:
Jul  4 11:48:29 devuan kernel: [ 2908.602600] cpcap_adc cpcap_adc.0:
error reading ADC: -110
Jul  4 11:48:29 devuan kernel: [ 2908.608123] cpcap_battery
cpcap_battery.0: cpcap_battery_get_current failed: -110
Jul  4 11:48:30 devuan kernel: [ 2908.922576] cpcap_adc cpcap_adc.0:
error reading ADC: -110
Jul  4 11:48:30 devuan kernel: [ 2908.928100] cpcap_battery
cpcap_battery.0: cpcap_charger_battery_temperature failed: -110
Jul  4 11:48:30 devuan kernel: [ 2908.936340] power_supply battery:
driver failed to report `voltage_now' property: -110

> Adding linux-pm at vger.kernel.org as it seems to be subsytem, specific.

Good idea. Thanks!
									pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180704/a1f2415d/attachment.sig>
