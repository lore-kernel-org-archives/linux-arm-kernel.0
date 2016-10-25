From: mranostay@gmail.com (Matt Ranostay)
Date: Tue, 25 Oct 2016 11:47:03 -0700
Subject: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval property
 query
In-Reply-To: <20161024201443.GB5989@amd>
References: <1475092512-30555-1-git-send-email-matt@ranostay.consulting>
 <1475092512-30555-3-git-send-email-matt@ranostay.consulting>
 <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
 <20161024201443.GB5989@amd>
Message-ID: <CAKzfze_rv29gwuBGctwTONyw8Oy6fwE+xcN0HMh-ZPB47HKzuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 1:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2016-10-24 12:58:25, Matt Ranostay wrote:
>> Pavel + Sebastian this is the patchset that need I some input on :)
>
> Better then previous one.
>
> But my version of bq27xxx_battery.c already contains this:

This is for allowing udev rule to set the properties as well.
otherwise a kinda crude RUN = " echo value >
/sys/module/bq27xxx_battery/parameters/poll_interval" is required.

>
> static const struct kernel_param_ops param_ops_poll_interval = {
>         .get = param_get_uint,
>         .set = poll_interval_param_set,
> };
>
> ...so it should be possible to set poll interval already.
>
>                                                                         Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
