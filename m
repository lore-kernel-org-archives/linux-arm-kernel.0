From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 24 Oct 2016 22:14:43 +0200
Subject: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval
 property query
In-Reply-To: <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
References: <1475092512-30555-1-git-send-email-matt@ranostay.consulting>
 <1475092512-30555-3-git-send-email-matt@ranostay.consulting>
 <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
Message-ID: <20161024201443.GB5989@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2016-10-24 12:58:25, Matt Ranostay wrote:
> Pavel + Sebastian this is the patchset that need I some input on :)

Better then previous one.

But my version of bq27xxx_battery.c already contains this:

static const struct kernel_param_ops param_ops_poll_interval = {
        .get = param_get_uint,
        .set = poll_interval_param_set,
};

...so it should be possible to set poll interval already.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/31406715/attachment.sig>
