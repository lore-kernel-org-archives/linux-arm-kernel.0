From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 3 Mar 2015 09:22:09 +0100
Subject: [linux-sunxi] Re: [PATCH] ARM: sun6i: dt: Add new Mele I7 device
In-Reply-To: <54F568F8.1040104@redhat.com>
References: <1425131285-8640-1-git-send-email-codekipper@gmail.com>
 <20150303071635.GC4713@lukather> <54F568F8.1040104@redhat.com>
Message-ID: <20150303082209.GE4713@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 08:55:36AM +0100, Hans de Goede wrote:
> >>+/ {
> >>+	model = "Mele I7 Quad top set box";
> >>+	compatible = "mele,i7", "allwinner,sun6i-a31";
> >>+
> >>+	chosen {
> >>+		bootargs = "earlyprintk console=ttyS0,115200";
> >
> >Using earlyprintk by default is a bad idea if the kernel is configured
> >with DEBUG_LL support for another SoC.
> 
> While on this subject, u-boot now sets the chosen/stdout-path property
> up by default, which means that the kernel will do the right thing by
> default. So we we really do not need any bootargs= in our dts files.

I just tested that this weekend, and it turned out that the kernel
couldn't use it so far (ie, no output until init takes over and setup
a TTY on ttyS0).

Was it working for you?

> Currently we've a random mix where we do have bootargs in some, but
> not in most sunxi dts files. I believe we should simply remove it
> everywhere...

We used to set them in SoCs that are not supported by U-boot yet, and
where the bootloader won't come and patch the DT (A31, A23, A80).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150303/844d5e5d/attachment-0001.sig>
