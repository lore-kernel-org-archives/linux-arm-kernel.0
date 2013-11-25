From: broonie@kernel.org (Mark Brown)
Date: Mon, 25 Nov 2013 15:48:37 +0000
Subject: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
In-Reply-To: <20131125031029.GC11613@S2101-09.ap.freescale.net>
References: <20131122142231.GA1741@ulmo.nvidia.com>
 <20131122145224.GO14725@sirena.org.uk>
 <20131125031029.GC11613@S2101-09.ap.freescale.net>
Message-ID: <20131125154837.GF14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 11:10:32AM +0800, Shawn Guo wrote:

> Hmm, I'm seeing this breakage on v3.13-rc1 now with the following line
> in the kernel log.

>   pwm-backlight backlight.18: dummy supplies not allowed

> What's missing here?

Are you racing with the late initcall to flag that DT is present?  Wei
Ni was looking at hooking this into DT so that when we pass the DT over
we flag that we have full constraints (or provide a notifier to let
subsystems do that) but that ground to a halt.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/729043dc/attachment.sig>
