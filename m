From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 24 Sep 2014 08:22:58 -0700
Subject: [PATCH v2] soc: qcom: do not disable the iface clock in probe
In-Reply-To: <1411500054-13600-1-git-send-email-srinivas.kandagatla@linaro.org>
 (Srinivas Kandagatla's message of "Tue, 23 Sep 2014 20:20:54 +0100")
References: <1411500054-13600-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <7hbnq5m4a5.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:

> since commit 31964ffebbb9 ("tty: serial: msm: Remove direct access to GSBI")'
> serial hangs if earlyprintk are enabled.
>
> This hang is noticed only when the GSBI driver is probed and all the
> earlyprintks before gsbi probe are seen on the console.
> The reason why it hangs is because GSBI driver disables hclk in its
> probe function without realizing that the serial IP might be in use by
> a bootconsole. As gsbi driver disables the clock in probe the
> bootconsole locks up.

> Turning off hclk's could be dangerous if there are system components
> like earlyprintk using the hclk.

This seems rather fragile.  Isn't the right fix for these other
components to use the clk api to ensure the clock does not get enabled?

Kevin
