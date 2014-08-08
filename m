From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri, 8 Aug 2014 11:16:41 +0100
Subject: [PATCH 3/8] arm: mm: reduce fixmap kmap from 32 to 16 CPUS
In-Reply-To: <CAL_JsqJZbbH=PwDzLKSwKiW1Y=N8MLgwEkp=xQaD_ST_uB-_Rw@mail.gmail.com>
References: <1407423713-4160-1-git-send-email-keescook@chromium.org>
 <1407423713-4160-4-git-send-email-keescook@chromium.org>
 <CAL_JsqJZbbH=PwDzLKSwKiW1Y=N8MLgwEkp=xQaD_ST_uB-_Rw@mail.gmail.com>
Message-ID: <20140808101640.GO4179@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 07, 2014 at 05:18:44PM -0500, Rob Herring wrote:
> On Thu, Aug 7, 2014 at 10:01 AM, Kees Cook <keescook@chromium.org> wrote:
> > More room is needed in the fixmap range for non-kmap fixmap entries. This
> > reduces the kmap range from 32 to 16 CPUs.
> 
> Do you want this merged or just doing this to get the rest of your
> series working? I'll post my patch for making the fixmap region 3MB
> (it adds back the first 1MB of the top pmd).

Well, I would quite like the generic fixmap stuff merged as soon as
possible, so that early_ioremap can go in. That way, the UEFI patches
are unblocked, and we can start booting the D01 in a sane way rather
than the broken-by-design built-in Linux loader.
 
/
    Leif
