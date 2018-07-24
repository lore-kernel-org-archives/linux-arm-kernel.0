From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Jul 2018 10:48:04 +0100
Subject: [PATCH] arm64: fix for restoring console loglevel after handling
 traps
In-Reply-To: <CAM5rFu9zVa3H=mqmSknALt-znb2MPwVbuy3atA5Qoi9KvGNXqQ@mail.gmail.com>
References: <1531993734-1463-1-git-send-email-hari.vyas@broadcom.com>
 <1531993734-1463-2-git-send-email-hari.vyas@broadcom.com>
 <20180719100140.GA424@jagdpanzerIV>
 <CAM5rFu_N-=26LddRy1mO010h9yLcGuKqK6=y+h=h3-HbfEP+FQ@mail.gmail.com>
 <20180719103916.g763zmsm7wnngwop@lakrids.cambridge.arm.com>
 <CAM5rFu-MFbH_2Pohmjydy232Rpt7_E84-K=e67wAu3iQzvTLiA@mail.gmail.com>
 <20180720121321.qgdsdtvvowhphava@pathway.suse.cz>
 <CAM5rFu-_sU1eSryFR-rDF=6BxZuf_E0xBQJ8RizNKYDB+DgWOQ@mail.gmail.com>
 <CAM5rFu9zVa3H=mqmSknALt-znb2MPwVbuy3atA5Qoi9KvGNXqQ@mail.gmail.com>
Message-ID: <20180724094804.e5hzljkn3twcmbd3@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 02:44:48PM +0530, Hari Vyas wrote:
> For tracking purpose, I have raised a separate bug for bad_mode() issue i.e.
> Bug 200637 - ARM64: bad_mode() handler may not result in panic always
> due to die() call in the beginning
> Probable fix could be to remove die() from bad_mode() but better other confirms.
> 
> As stated, die() is called from other places also my feeling and
> logically restoration  is required. Please
> confirm whether to close this issue without any change or proceed with
> only one restore() call in die and discard at
> other 3 places.

I think that if we've encountered a die(), leaving the loglevel up is
fine. Something has gone very wrong, regardless of whether we try to
continue.

Mark.
