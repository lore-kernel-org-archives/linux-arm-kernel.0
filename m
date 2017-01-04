From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 4 Jan 2017 12:43:32 +0100 (CET)
Subject: [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
In-Reply-To: <20170104110750.dtu54t74qkuuvkvq@piout.net>
References: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
 <20170102140654.GF14217@n2100.armlinux.org.uk>
 <CAGXu5jJLA=GcOhV5Z_6AOGa1KhW7fXtqBGrewEeViaJ9TiE-aw@mail.gmail.com>
 <20170103213118.GM14217@n2100.armlinux.org.uk>
 <20170103215421.GN14217@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1701041155380.3073@hadrien>
 <20170104110750.dtu54t74qkuuvkvq@piout.net>
Message-ID: <alpine.DEB.2.20.1701041242080.3073@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The question was whether the point to the rtc_class_ops could be made
> __ro_after_init. And Russell is right, it is pointed to by the ops
> pointer in a struct rtc_device and that struct is dynamically allocated
> in rtc_device_register().

OK, I think it's a terminology issue.  You mean the structure that
contains the pointer, and not the pointer itself, which is already const.

thanks,
julia
