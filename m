From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 7 Jul 2012 13:49:13 +0300
Subject: [PATCH 1/3] hwspinlock/core: use global ID to register
 hwspinlocks on multiple devices
In-Reply-To: <4FF66FE6.1060005@renesas.com>
References: <4FF66FBD.5090601@renesas.com> <4FF66FE6.1060005@renesas.com>
Message-ID: <CAK=WgbYgrnWjdyrt+qwuBDvsgSWmQKXsbsQfHdAhNWG_=ZH=Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 6, 2012 at 7:56 AM, Shinya Kuribayashi
<shinya.kuribayashi.px@renesas.com> wrote:
> Commit 300bab9770 (hwspinlock/core: register a bank of hwspinlocks in a
> single API call, 2011-09-06) introduced 'hwspin_lock_register_single()'
> to register numerous (a bank of) hwspinlock instances in a single API,
> 'hwspin_lock_register()'.
>
> At which time, 'hwspin_lock_register()' accidentally passes 'local IDs'
> to 'hwspin_lock_register_single()', despite that ..._single() requires
> 'global IDs' to register hwspinlocks.
>
> We have to convert into global IDs by supplying the missing 'base_id'.
>
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

Applied, thanks!

While at it, I also fixed the error path of hwspin_lock_register,
which had the same bug.
