From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 18 May 2018 09:14:36 +0200
Subject: [PATCH v4 3/3] ARM: dts: sun7i: Add support for the Ainol AW1
 tablet
In-Reply-To: <0da5787f0ce2309a74db88820bc58b3b3501c451.camel@paulk.fr>
References: <20180507220413.21990-1-contact@paulk.fr>
 <20180507220413.21990-3-contact@paulk.fr>
 <20180511143647.ici2bfoeeldto3ju@flea>
 <0da5787f0ce2309a74db88820bc58b3b3501c451.camel@paulk.fr>
Message-ID: <20180518071436.3vvyllghrdxptsxg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 10:36:08PM +0200, Paul Kocialkowski wrote:
> > > +	backlight: backlight {
> > > +		compatible = "pwm-backlight";
> > > +		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> > > +		brightness-levels = <  0   1   1   1   1   2   2   2
> > > +				       2   3   3   3   3   4   4   4
> > > +				       5   5   5   6   6   6   7   7
> > > +				       8   8   8   9   9   9  10  10
> > > +				      10  11  11  12  12  12  13  13
> > > +				      14  14  14  15  15  16  16  17
> > > +				      17  17  18  18  19  19  20  20
> > > +				      21  21  21  22  22  23  23  24
> > > +				      24  25  25  26  26  27  27  28
> > > +				      28  29  30  30  31  31  32  32
> > > +				      33  33  34  35  35  36  36  37
> > > +				      38  38  39  39  40  41  41  42
> > > +				      43  43  44  44  45  46  47  47
> > > +				      48  49  49  50  51  51  52  53
> > > +				      54  54  55  56  57  57  58  59
> > > +				      60  61  61  62  63  64  65  65
> > > +				      66  67  68  69  70  71  71  72
> > > +				      73  74  75  76  77  78  79  80
> > > +				      81  82  83  84  85  86  87  88
> > > +				      89  90  91  92  93  94  95  96
> > > +				      97  98  99 101 102 103 104 105
> > > +				     106 108 109 110 111 112 114 115
> > > +				     116 117 119 120 121 123 124 125
> > > +				     127 128 129 131 132 133 135 136
> > > +				     138 139 141 142 144 145 147 148
> > > +				     150 151 153 154 156 157 159 161
> > > +				     162 164 166 167 169 171 173 174
> > > +				     176 178 180 181 183 185 187 189
> > > +				     191 192 194 196 198 200 202 204
> > > +				     206 208 210 212 214 216 219 221
> > > +				     223 225 227 229 232 234 236 238
> > > +				     241 242 244 246 248 250 253 255>;
> > 
> > You kind of overdid it here :)
> > 
> > What I meant to say before was that if you have 10 elements (and you
> > really should have something in that magnitude) each step should
> > increase the perceived brightness by 10%.
> 
> Mhh I think 10 elements would fall too short to really depict the curve
> with appropriate precision. Given the usual size for brightness cursors
> in e.g. gnome-shell, it feels like a bigger number would be more
> appropriate. Let's make it to 100 with values from 0 to 255!
> 
> > In this particular case, I really think having something close to <0 4
> > 8 16 32 64 128 255> would be enough.
> > 
> > And in general, that kind of odd looking table without any more
> > context is just screaming for a comment :)
> 
> Noted, I will explain the idea, but probably without the exact formula
> that's really a nasty hack written down on a piece of paper sitting in
> my garbage at this point.

So no one will ever be able to understand where this sequence comes
from (yourself-in-two-years included). That sounds like a pretty bad
idea.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180518/7fd364f8/attachment-0001.sig>
