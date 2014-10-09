From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 9 Oct 2014 12:26:20 -0700
Subject: [PATCH v8 4/7] qcom: pm: Add cpu low power mode functions
In-Reply-To: <20141009190057.GA5493@codeaurora.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-5-git-send-email-lina.iyer@linaro.org>
 <5435E245.1090507@codeaurora.org>
 <20141009155643.GB1277@ilina-mac.local>
 <20141009190057.GA5493@codeaurora.org>
Message-ID: <20141009192620.GB5493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09, Stephen Boyd wrote:
> On 10/09, Lina Iyer wrote:
> > On Wed, Oct 08 2014 at 19:17 -0600, Stephen Boyd wrote:
> > 
> > >>+static int __init qcom_pm_device_init(void)
> > >>+{
> > >>+	platform_device_register(&qcom_cpuidle_device);
> > >>+
> > >
> > >This is wrong. We're going to register a platform device whenever
> > >this file is included in a kernel. This is then going to try and
> > >probe the qcom_cpuidle device which is going to fail and print an
> > >error message if we're not running on a qcom device.
> > Why would this file be compiled on a non-qcom target? The file has a
> > dependency on ARCH_QCOM (as it should be) and would not be compiled on a
> > non-qcom target.
> 
> We will compile this file on non-qcom devices in a multi-platform
> kernel build. Actually that looks like it would be a problem
> because cpuidle_register() will blow away any other registered
> driver on non-qcom devices.

Oh right, this won't happen because we won't have the idle states
in the CPU node. We'll just get the annoying error message
instead.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
