From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 21 Feb 2017 12:07:12 +0100
Subject: [PATCH/RFC 3/6] drivers: firmware: psci: Implement shallow
 suspend mode
In-Reply-To: <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-4-git-send-email-geert+renesas@glider.be>
Message-ID: <20170221110712.GB5021@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Enable support for "shallow" suspend mode, also known as "Standby" or
> "Power-On Suspend".
> 
> As secondary CPU cores are taken offline, "shallow" suspend mode saves
> slightly more power than "s2idle", but less than "deep" suspend mode.
> However, unlike "deep" suspend mode, "shallow" suspend mode can be used
> regardless of the presence of support for PSCI_SYSTEM_SUSPEND, which is
> an optional API in PSCI v1.0.

If system supports "shallow" suspend, why does not PSCI implement it?

In the past, I was told PSCI will not turn into ACPI-like mess, and
that we'll be able to fix PSCI and will not have to work around its
problems in kernel :-(.

Not your fault, Mark made those promises.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/96d9dd2b/attachment.sig>
