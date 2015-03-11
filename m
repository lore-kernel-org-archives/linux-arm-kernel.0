From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Mar 2015 10:46:42 +0000
Subject: [PATCH 2/5] arm64: use fixmap region for permanent FDT mapping
In-Reply-To: <CAKv+Gu-=_LGYLPcDw3od04x5MneDXHN8goUg=zdmv-hBaj_H-g@mail.gmail.com>
References: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425380630-3684-3-git-send-email-ard.biesheuvel@linaro.org>
 <CAL_JsqLdFS_nGuLTxrEZPCQv8MtW0s5jQ9Od1qj41yoqX40ONQ@mail.gmail.com>
 <CAKv+Gu8xrb0QqeFCfbqOb2sxFPyT8cVaq_RkhiD5jrr8L0zYzA@mail.gmail.com>
 <20150311095055.GB21430@leverpostej>
 <CAKv+Gu-=_LGYLPcDw3od04x5MneDXHN8goUg=zdmv-hBaj_H-g@mail.gmail.com>
Message-ID: <20150311104641.GC4114@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I agree with Mark's observation that 2 MB seems reasonable at the
> moment, but on the other hand, the code only requires minor tweaking
> to make the limit configurable simply by changing the FIX_FDT_SIZE
> define, so I don't mind changing that.

We should have a common limit rather than a configurable option; there's
no point building a compatibility nightmare for ourselves when the only
thing we lose is a few entries in the fixmap.

I'm happy to bump the max size for the DTB, but I'd like to see a
reasonable example of a DTB approaching or exceeding that first.

Mark.
