From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 8 Apr 2013 13:20:57 +0100
Subject: [PATCH V3 4/5] spi: s3c64xx: Added provision for dedicated cs pin
In-Reply-To: <CAKrE-KevVramLc1n_9kcfHVb=RKT_kexQ8iUP-5+BL3wxpMPbQ@mail.gmail.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
 <1363157014-9615-5-git-send-email-ks.giri@samsung.com>
 <20130401125744.GG18636@opensource.wolfsonmicro.com>
 <CAKrE-Kd+YAFmteDdh3odtV+YU1=OjoMuQV9usF4NmUse+TXhTg@mail.gmail.com>
 <20130408101530.GC9243@opensource.wolfsonmicro.com>
 <CAKrE-KevVramLc1n_9kcfHVb=RKT_kexQ8iUP-5+BL3wxpMPbQ@mail.gmail.com>
Message-ID: <20130408122056.GG9243@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 05:15:26PM +0530, Girish KS wrote:
> On Mon, Apr 8, 2013 at 3:45 PM, Mark Brown

> > Two options here, one is to just assume nobody will use GPIO 0 and the
> > other is to set the number appopriately during probe so that only probe
> > needs to worry about the issue.
> 
> In the second option if the gpio number is set in the probe, then we
> are overwriting the
> actual gpio number assigned in the platform data.
> If I move the cs_gpio from the platform data to controller private
> data then the dependency
> on other platforms can be removed, but still the check (true or false)
> before setting the gpio
> line will remain. If agreed upon this i can go ahead and post the patch

I think logic in probe should be fine, it just felt really cumbersome
having this on every single use but doing it once on probe ought to be
OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130408/16a9e989/attachment.sig>
