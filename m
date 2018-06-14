From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 14 Jun 2018 21:44:38 +0200
Subject: [PATCH v7 3/6] DTS: gta04: add uart2 child node for w2sg0004 GPS
 receiver
In-Reply-To: <9ebb28aed589aca8e9b5bc5c910f1d2f0d62669d.1525340143.git.hns@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
 <9ebb28aed589aca8e9b5bc5c910f1d2f0d62669d.1525340143.git.hns@goldelico.com>
Message-ID: <20180614194428.GA17808@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2018-05-03 11:35:48, H. Nikolaus Schaller wrote:
> GTA04 has a W2SG0004 module connected to UART2 of the OMAP3
> processor. A GPIO can pulse the on/off toggle switch.
> 
> Note that there is no WAKEUP output from the W2SG0004,
> hence we can't use the generic SirfStar binding.
> 
> The VSIM regulator is used to power on/off the LNA of an
> external active GPS antenna so that a driver can turn the
> LNA off if GPS is not needed to save battery energy.

This reads as if you did low->high->low to turn GPS on, then
low->high->low to turn GPS off again. Is that correct?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180614/8a830def/attachment.sig>
