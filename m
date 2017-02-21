From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 21 Feb 2017 12:07:30 +0100
Subject: [PATCH/RFC 4/6] drivers: firmware: psci: Fix non-PMIC wake-up if
 SYSTEM_SUSPEND cuts power
In-Reply-To: <1487622809-25127-5-git-send-email-geert+renesas@glider.be>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-5-git-send-email-geert+renesas@glider.be>
Message-ID: <20170221110730.GF5021@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2017-02-20 21:33:27, Geert Uytterhoeven wrote:
> Nothing in the PSCI specification requires the SoC to remain powered and
> to support wake-up sources when suspended using SYSTEM_SUSPEND.
> If the firmware implements the PSCI SYSTEM_SUSPEND operation by cutting
> power to the SoC, the only possibly wake-up sources are thus the ones
> connected to the PMIC.
> 
> Document and add support for an "arm,psci-system-suspend-is-power-down"
> DT property, so Linux uses a different suspend method when other wake-up
> sources (e.g. wake on LAN, UART or GPIO) are enabled.

Should we make PSCI return that information? (At least in next
specification version?)

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/5320f29d/attachment.sig>
