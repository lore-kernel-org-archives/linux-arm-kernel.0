From: dianders@chromium.org (Doug Anderson)
Date: Thu, 19 Feb 2015 17:04:50 -0800
Subject: [PATCH v4 1/3] mmc: dw_mmc: update clock after host reach a
 stable voltage
In-Reply-To: <CAD=FV=V9aK-78GJ_eWkpZZdVT_5Zu8ehxg_o3NtnpD2wyRuh7Q@mail.gmail.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
 <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
 <1423894668-8886-2-git-send-email-addy.ke@rock-chips.com>
 <CAGOxZ53ndi_hYDGBGhY-7q8aOrFid1=D=_5KEbUvzTsnybJQ3Q@mail.gmail.com>
 <CAD=FV=V9aK-78GJ_eWkpZZdVT_5Zu8ehxg_o3NtnpD2wyRuh7Q@mail.gmail.com>
Message-ID: <CAD=FV=VSYQs8p9m_+dmXmkMmxgqzDA6EGZ9Vfy3wsby5k5NitQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 19, 2015 at 3:49 PM, Doug Anderson <dianders@chromium.org> wrote:
> I've got that coded up but I'm still testing it...  If you want to try
> it too, you can find it at
> <https://chromium-review.googlesource.com/251341>.
>
> Note that without my patch I find that I _really_ need Addy's patch to
> make sure that the card isn't busy in setup_bus.  With my patch Addy's
> code catches the card busy less often.  I'm still trying to see if
> there's a way to totally remove the need for his setup_bus and still
> trying to grok all the patches flying around...

Ah, this might be the magic needed:

https://chromium-review.googlesource.com/251344


I think that together with the previous patch things are happy for me
without any of Addy's patches, though it's the end of my work day and
I haven't given this nearly as much testing as I'd like.

I'll continue testing tomorrow and then post both patches together upstream.

-Doug
