From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 31 Aug 2015 09:49:41 +0200
Subject: [PATCH 3/7] dmaengine: st_fdma: Add STMicroelectronics FDMA
 engine driver support
In-Reply-To: <1436429872.20619.77.camel@tiscali.nl>
References: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
 <1436371888-27863-4-git-send-email-peter.griffin@linaro.org>
 <1436429872.20619.77.camel@tiscali.nl>
Message-ID: <55E40715.1040204@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 07/09/2015 10:17 AM, Paul Bolle wrote:
>> >+static int __exit st_fdma_remove(struct platform_device *pdev)
>> >+{
>> >+	struct st_fdma_dev *fdev = platform_get_drvdata(pdev);
>> >+
>> >+	wait_for_completion(&fdev->fw_ack);
>> >+
>> >+	st_fdma_clk_disable(fdev);
>> >+
>> >+	return 0;
>> >+}
> Since this driver is built-in only this means st_fdma_remove() can never
> be used, right?
>

It's not because a driver is built-in only that it does not need a 
remove callback.
An instance can be probed/removed any time via driver's bind/unbind 
SysFS entries.
Am I missing something?

Kind regards,
Maxime
