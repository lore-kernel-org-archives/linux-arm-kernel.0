From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Apr 2014 16:20:24 +0200
Subject: [PATCH 1/7] gpiolib: gpiolib-of: Implement device tree
 gpio-names based lookup
In-Reply-To: <1397544101-18135-2-git-send-email-wens@csie.org>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
 <1397544101-18135-2-git-send-email-wens@csie.org>
Message-ID: <20140415142024.GD3207@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Tue, Apr 15, 2014 at 02:41:35PM +0800, Chen-Yu Tsai wrote:
> This patch provides of_get_gpiod_flags_by_name(), which looks up GPIO
> phandles by name only, through gpios/gpio-names, and not by index.

IIRC, gpios only uses the *-gpios properties, and not gpios/gpio-names
pattern seen on various other things.

Is it some new property you introduce? If so, please add it to the
documentation.

Now, I'm not sure that having two distinct representations of GPIOs in
the DT is a good thing. Yes, it's looking odd compared to other
similar bindings, but it's what we have to deal with.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/82315949/attachment.sig>
