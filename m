From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 11 May 2015 21:11:59 +0200
Subject: [linux-sunxi] Re: [PATCH v2 04/13] musb: Do not use musb_read[b|w]
 / _write[b|w] wrappers in generic fifo functions
In-Reply-To: <10106387.CZmapdhaD3@wuerfel>
References: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
 <20150511155846.GH19476@saruman.tx.rr.com> <5550F174.6000709@redhat.com>
 <10106387.CZmapdhaD3@wuerfel>
Message-ID: <5550FEFF.9010403@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11-05-15 20:53, Arnd Bergmann wrote:
> On Monday 11 May 2015 20:14:12 Hans de Goede wrote:
>> Also note, that as I've tried to explain in the commit message already this commit
>> makes no functional changes what so ever, the generic musb_default_read/write_fifo
>> functions are only used by musb platforms which do not overwrite musb_write* /
>> musb_read* and musb_write* / musb_read* are already just thin wrappers around
>> the __raw_* functions.
>
> Oh, that's a bit odd:  That would mean that the defaults are also broken on
> big-endian platforms, and fixing them would introduce the bug here, unless your
> patch is applied.
>
> Any idea why musb uses the __raw_* functions to start with? Can we change
> them to read?_relaxed()/write?_relaxed() now that those are available on
> all architectures?

I'm afraid I've no idea, since the musb code is somewhat obscure / tricky
in places I've done my best to not make any functional changes what so ever
in the entire set, chances are things will work fine with just readl / writel
but verifying that is hard, so I've gone for the better safe then sorry approach.

Regards,

Hans
