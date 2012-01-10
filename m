From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 10 Jan 2012 11:04:33 +0000
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
Message-ID: <20120110110433.GA2336@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 11:26:38PM +0000, Tabi Timur-B04825 wrote:
> On Wed, Sep 21, 2011 at 4:19 AM, Dave Martin <dave.martin@linaro.org> wrote:
> >
> > ? ? ?* edid -- It should be possible to have a fairly generic binding
> > ? ? ? ?for EDID interfaces, but none seems to exist yet. ?Discussion
> > ? ? ? ?is needed regarding what form this should take.
> >
> > ? ? ? ?This might more appropriately be called "ddc" (or some
> > ? ? ? ?variation on that), since EDID seems only to describe the
> > ? ? ? ?format of the ID data retrievable via this interface; not the
> > ? ? ? ?interface itself.
> 
> Has there been any progress on this issue?  I'm looking to add EDID
> support to a PowerPC device tree.  A TI developer is using
> "ti,eeprom", but I'm not sure that's a good choice.

It turns out that because of the way things are wired up on vexpress, the
EDID is not really usable; so I wasn't planning to do anything about it.


I don't really know enough about this field to comment on whether it's
genuinely useful to have a specific binding for EDID.  If it's enough
to reference the appropriate I2C bus node from the display device node,
then I guess we don't necessarily need to worry about having a separate
binding.

If it makes no sense to attempt make EDID access fully generic, that
would sound like the right approach.

Cheers
---Dave
