From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 23 Nov 2017 00:06:33 +0100
Subject: [PATCH 3/4] ARM: pxa/spitz: Remove hardcoded partitioning, use
 sharpslpart parser
In-Reply-To: <1511300631-1343-3-git-send-email-andrea.adami@gmail.com>
References: <1511300631-1343-1-git-send-email-andrea.adami@gmail.com>
 <1511300631-1343-3-git-send-email-andrea.adami@gmail.com>
Message-ID: <20171122230633.GC3623@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2017-11-21 22:43:50, Andrea Adami wrote:
> With the introduction of sharpslpart partition parser we can now read the
> offsets from NAND: we specify the list of the parsers as platform data, with
> cmdlinepart and ofpart parsers first allowing to override the part. table
> written in NAND. This is done here in the board file.
> 
> Emulators like qemu will need to pass the mtdparts in the cmdline.

IOW this will be regression for people emulating zaurus in qemu.

...

Is it good idea? Its not like this platform data is particulary big or
changes very often...

> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171123/49171f1f/attachment-0001.sig>
