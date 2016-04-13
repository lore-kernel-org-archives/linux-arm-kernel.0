From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 Apr 2016 18:23:18 +0100
Subject: [PATCH 2/5] regulator: st-flashss: Add a regulator driver for
 flashss vsense.
In-Reply-To: <570DFC44.8060408@st.com>
References: <1460474204-5351-1-git-send-email-peter.griffin@linaro.org>
 <1460474204-5351-3-git-send-email-peter.griffin@linaro.org>
 <20160413061514.GI14664@sirena.org.uk> <570DFC44.8060408@st.com>
Message-ID: <20160413172318.GC29471@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 09:59:00AM +0200, Giuseppe CAVALLARO wrote:
> On 4/13/2016 8:15 AM, Mark Brown wrote:
> >>>+static void st_get_satinize_powerup_voltage(struct st_vsense *vsense)
> >>>+{

> >or am I missing something?  Why do we need to do this anyway, it's very
> >surprsing?

> This functions is to sanitize the vsense voltages when the regulator
> is probed and in some circumstances the reset value of this register
> does not reflect the hw status/config. For example, by default, after
> the reset, the bit 0 is set so the EMMC, inside the flash subsystem,
> is supposed to operate at 3v3. But the latched bit 24 can be 0 on
> a platform where it is actually set at 1v8.
> So the bit 0 must be reset to keep this coherent and to allow MMC
> framework to properly setup the Vdd when the framework starts.

I'm afraid I can't follow that explanation, perhaps because I don't know
anything about the content of this register except for these three bits.
I think we do need a comment in the driver explaining what's going on,
and probably a simplification of the code too if my understanding of the
effect of all those operations is correct.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160413/af3aaa8a/attachment.sig>
