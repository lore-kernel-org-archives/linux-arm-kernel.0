From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 1 Nov 2018 13:03:43 +0530
Subject: [PATCH 5/7] arm64: allwinner: h6: Add RTC node
In-Reply-To: <CAGb2v64fnpCh_rCy-9m8xgXmAZQGab1==f7cr332QfgueyuRNw@mail.gmail.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-5-jagan@amarulasolutions.com>
 <CAGb2v64fnpCh_rCy-9m8xgXmAZQGab1==f7cr332QfgueyuRNw@mail.gmail.com>
Message-ID: <CAMty3ZAW5KndyJj81obK49MKczdbk4SoUncmiiE_OhH1g7qFUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2018 at 8:25 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Nov 1, 2018 at 2:37 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > From: Jagan Teki <jagan@openedev.com>
> >
> > RTC controller is similar to A31, so use the same compatible
> > for H6 and update interrupt numbers as per manual.
>
> No. Unfortunately they are not that compatible. The A31 does not have
> the RTC clock output. So everyone got it wrong. :( Plus the clock rate
> of the internal RC oscillator varies between SoCs. I'm working on a
> series of patches to correct this. Stay tuned.

4 bit, EXT_LOSC_EN of LOSC_CTRL_REG (0x00) seem available in H6. I can
see external clock working with WIFI for A31 compatible.
