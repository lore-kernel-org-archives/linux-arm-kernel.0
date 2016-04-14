From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Apr 2016 16:25:30 +0100
Subject: [PATCH 2/5] regulator: st-flashss: Add a regulator driver for
 flashss vsense.
In-Reply-To: <570FA606.4070908@st.com>
References: <1460474204-5351-1-git-send-email-peter.griffin@linaro.org>
 <1460474204-5351-3-git-send-email-peter.griffin@linaro.org>
 <20160413061514.GI14664@sirena.org.uk> <570DFC44.8060408@st.com>
 <20160413172318.GC29471@sirena.org.uk> <570FA606.4070908@st.com>
Message-ID: <20160414152530.GH18024@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 04:15:34PM +0200, Giuseppe CAVALLARO wrote:
> On 4/13/2016 7:23 PM, Mark Brown wrote:

> 	/*
> 	 * After resetting, the CONFIG_REG_PSW_<xxx> are set, this
> 	 * means 3v3 operating voltage.
> 	 * The CONFIG_LATCHED_PSW_<xxx> must be used to fix the previous
> 	 * bits so operating at 1v8 if this is the real HW configuration
> 	 * at boot time.
> 	 */
> 	if (!(value & TOP_VSENSE_CONFIG_LATCHED_PSW_EMMC))
> 		value &= ~TOP_VSENSE_CONFIG_REG_PSW_EMMC;

That's definitely better.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160414/4ebe1c40/attachment-0001.sig>
