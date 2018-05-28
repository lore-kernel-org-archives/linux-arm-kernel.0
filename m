From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 28 May 2018 10:44:46 +0200
Subject: [PATCH 06/15] arm: dts: sun: Add missing cooling device
 properties for CPUs
In-Reply-To: <eded393f4b508a1f377f9af6859a3b82a6787e1c.1527244201.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <eded393f4b508a1f377f9af6859a3b82a6787e1c.1527244201.git.viresh.kumar@linaro.org>
Message-ID: <20180528084446.g24fphqqac2hi3rr@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 25, 2018 at 04:01:52PM +0530, Viresh Kumar wrote:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
> 
> Add such missing properties.
> 
> Fix other missing properties (clocks, OPP, clock latency) as well to
> make it all work.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

The prefix should be sunxi and not sun, but it looks good to me
otherwise.

Let me know what your preferred merge method is.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180528/a2bdcdbe/attachment.sig>
