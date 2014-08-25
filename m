From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Aug 2014 17:07:05 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140825145303.GC14763@ulmo.nvidia.com>
References: <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
Message-ID: <20140825150705.GB15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 04:53:06PM +0200, Thierry Reding wrote:
> Hmm... that's true. But we already have a way to deal with exactly this
> situation for regulators. There's a property called regulator-boot-on
> which a bootloader should set whet it has enabled a given regulator. It
> can of course also be set statically in a DTS if it's know upfront that
> a bootloader will always enable it. Perhaps what we need is a similar
> property for clocks so that the clock framework will not inadvertently
> turn off a clock that's still being used.

Except that such a property won't work either. Regulators with
regulator-boot-on will still be disabled if there's no one to claim
it. Just like what happens currently for the clocks.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140825/69496455/attachment.sig>
