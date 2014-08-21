From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 21 Aug 2014 08:40:27 +0200
Subject: [PATCH v3 2/4] pwm: rockchip: Allow polarity invert on rk3288
In-Reply-To: <387c82a0-efeb-431d-b8a5-200f24bc47ff@email.android.com>
References: <1408464476-28316-1-git-send-email-dianders@chromium.org>
 <1408464476-28316-3-git-send-email-dianders@chromium.org>
 <20140820100447.GG15414@ulmo>
 <CAD=FV=U9gOiY=4s7WmAQcm0n9s67nWdqQ3A0L2B7Dg83dNotjQ@mail.gmail.com>
 <387c82a0-efeb-431d-b8a5-200f24bc47ff@email.android.com>
Message-ID: <20140821064026.GC4486@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 02:29:17PM -0500, Dmitry Torokhov wrote:
> On August 20, 2014 1:54:11 PM CDT, Doug Anderson <dianders@chromium.org> wrote:
> >On Wed, Aug 20, 2014 at 3:04 AM, Thierry Reding
> ><thierry.reding@gmail.com> wrote:
> >> On Tue, Aug 19, 2014 at 09:07:54AM -0700, Doug Anderson wrote:
> >>> The rk3288 has the ability to invert 
> >>> +     struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> >>> +
> >>> +     if (!pc->data->has_invert)
> >>> +             return -ENOSYS;
> >>> +
> 
> At the kernel summit hpa also mentioned that ENOSYS should only be
> used for missing syscalls. Not sure what error code would suit better
> here though...

I'd be interested in the rationale why ENOSYS shouldn't be used within
the kernel. As long as it doesn't leak to userspace where it could
possibly confuse applications I don't see any harm in using it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/44ef4883/attachment.sig>
