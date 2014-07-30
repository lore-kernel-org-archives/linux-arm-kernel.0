From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 30 Jul 2014 12:26:00 +0100
Subject: [PATCH v15 07/12] ARM: dts: append hip04 dts
In-Reply-To: <CAOesGMi6xLwFkjctNJsJ63WYaMhrJgjNyST4qiUpa42e4biBjQ@mail.gmail.com>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-8-git-send-email-haojian.zhuang@linaro.org>
 <20140728180609.GE2576@leverpostej>
 <CAD6h2NQLgB1=8+WznE19rjsFwm3XWPUYEbDuPCbKbWjseRCBDg@mail.gmail.com>
 <20140729123221.GN2576@leverpostej>
 <CAOesGMi6xLwFkjctNJsJ63WYaMhrJgjNyST4qiUpa42e4biBjQ@mail.gmail.com>
Message-ID: <20140730112559.GG4179@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 10:01:48AM -0700, Olof Johansson wrote:
> >> In this platform, we relied on the bootwrapper. If I discard this,
> >> I'll fail to bring up all secondary cores.
> >
> > What loads the boot wrapper into memory, and from where?
> >
> > In another reply you mentioned you're using UEFI. Is this wrapper
> > considered part of your UEFI implementation? If so it should be reserved
> > in the UEFI memory map, and there should be no need of memory nodes or
> > memreserves -- all that should come from UEFI.
> 
> There's no UEFI memory map parsing on 32-bit, is there?

There is in my patch set, but that is still dependent on the
early_ioremap support, which needs someone to comment on the "use
generic fixmap on ARM" bit.
 
/
    Leif
