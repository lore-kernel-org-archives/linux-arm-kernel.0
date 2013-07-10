From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Jul 2013 11:00:20 +0100
Subject: [PATCH v4 1/7] sound: sam9x5_wm8731: machine driver for
 at91sam9x5 wm8731 boards
In-Reply-To: <CACQ1gAgHuAcBAAgYaP-n9grrM6X0L9b1mFFfkRg0HH_RnRuXMg@mail.gmail.com>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-2-git-send-email-richard.genoud@gmail.com>
 <20130709145917.GA27646@sirena.org.uk>
 <CACQ1gAgHuAcBAAgYaP-n9grrM6X0L9b1mFFfkRg0HH_RnRuXMg@mail.gmail.com>
Message-ID: <20130710100020.GA24508@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 11:25:37AM +0200, Richard Genoud wrote:
> 2013/7/9 Mark Brown <broonie@kernel.org>:

> > Shouldn't the SSC driver be enforcing this constraint if it comes from
> > the SSC hardware?  If the clock is reprogrammable the usual convention
> > for drivers is to not constrain if the clock is set to zero so a machine
> > driver could remove the constraint.

> Actually, my comment is buggy here (or at least, unrelated to the
> authorized rates).
> The "MCLK_RATE" is the master clock of the wm8731 codec (a 12.288MHz crystal).
> According to the datasheet of wm8731, when a 12.288 crystal is used,
> the authorized rates are 8, 32, 48 and 96kHz (I have to remove 16 and
> 64kHz).

> So, is this the right place for the rates ?

No, the CODEC driver should be enforcing the restrictions if that's
where they come from.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130710/45362626/attachment.sig>
