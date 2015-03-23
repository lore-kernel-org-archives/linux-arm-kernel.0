From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 23 Mar 2015 19:32:11 +0100
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <550EBDBC.9000903@gmail.com>
References: <55097C46.9010605@gmail.com> <20150318140037.GE3580@katana>
 <550A05E5.3050100@gmail.com> <20150319100944.GA914@katana>
 <550AEF9D.6090307@wwwdotorg.org> <20150319160208.GF7657@katana>
 <550B3725.10209@gmail.com> <20150320101925.GC2071@katana>
 <20150321210028.GA1078@katana> <550EBDBC.9000903@gmail.com>
Message-ID: <20150323183211.GB1128@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> If modifying i2c-mux-pinctrl to respect the sub-bus status property is
> such a big issue, I'd rather leave the driver as is and expose all
> sub-busses to userspace.

Well, dunno what 'big issue' is in your book :) What definately needs to
be done is:

* handle "status" at mux-core level, not mux-driver
* that probably needs us to convert i2c_add_mux_adapter() to return
  ERR_PTRs instead of NULL, so we can distinguish the "disabled" case
* that would mean to fix all existing users

That's all not groundbreaking stuff, but needs caution and thoroughness.
There might be some gory details left, though...

Regards,

   Wolfram
