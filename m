From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Nov 2012 17:17:22 +0900
Subject: [PATCH 1/1] regulator: gpio-regulator: fix crash when no states
 property in dt
In-Reply-To: <CAHrpEqTF80XyRD8ZTDGLs+AywznGNdvZfndfWSuw+pJ-D24Rxw@mail.gmail.com>
References: <1352450076-22682-1-git-send-email-Frank.Li@freescale.com>
 <20121109165609.GV23807@opensource.wolfsonmicro.com>
 <CAHrpEqSbydeAHngL-NMfQa1HQUsj0US5u=aK6y-ku0DMOW-KkA@mail.gmail.com>
 <20121113075733.GN18224@opensource.wolfsonmicro.com>
 <CAHrpEqTF80XyRD8ZTDGLs+AywznGNdvZfndfWSuw+pJ-D24Rxw@mail.gmail.com>
Message-ID: <20121113081720.GO18224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 04:12:14PM +0800, Frank Li wrote:

> Yes, I tested it.
> I use gpio-enable to turn on\off a sensor power switcher.
> the below is a part of my dt file.

You should really use a fixed voltage regulator here, or fix the code so
you can specify a voltage for the gpio regulator when no GPIO is
specified (ideally the two drivers would be unified but that's another
story and mostly orthogonal to the DT).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/5c5a887c/attachment.sig>
