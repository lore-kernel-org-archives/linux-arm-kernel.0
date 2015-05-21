From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 21 May 2015 19:59:13 +0200
Subject: [PATCH] ARM: rockchip: restore dapswjdp after suspend
In-Reply-To: <CAD=FV=XARAYzLWy+i9f1XuTZTa4RiA5Yb9aJoAuh9uJmgs-ZOQ@mail.gmail.com>
References: <1432154048-19126-1-git-send-email-dianders@chromium.org>
 <555D3CB7.2000002@rock-chips.com>
 <CAD=FV=XARAYzLWy+i9f1XuTZTa4RiA5Yb9aJoAuh9uJmgs-ZOQ@mail.gmail.com>
Message-ID: <2799695.KoAD3Q19Xm@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

Am Donnerstag, 21. Mai 2015, 08:40:55 schrieb Doug Anderson:
> On Wed, May 20, 2015 at 7:02 PM, Huang, Tao <huangtao@rock-chips.com> wrote:
> >> It turns out that's not a safe assumption.  In some cases (pending
> >> interrupts) it's possible that the WFI might act as a no-op and the
> >> MaskROM will never run.
> > Anyway, restore the value is okay, which make the code more symmetrically
> 
> OK.  Heiko: applying this won't hurt, but it will only be useful if we
> find a way to return from the WFI successfully...

As it looks sane but doesn't fix an immediate problem I have applied this to my 
soc-branch for 4.2 .


Thanks
Heiko
