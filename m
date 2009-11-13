From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Nov 2009 13:09:56 +0000
Subject: [PATCH 09/10] input: enable touch on 88pm860x
In-Reply-To: <771cded00911130104s3bc6ff97ma3a7f7ad76ae9198@mail.gmail.com>
References: <771cded00911130104s3bc6ff97ma3a7f7ad76ae9198@mail.gmail.com>
Message-ID: <20091113130956.GB21516@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 04:04:44AM -0500, Haojian Zhuang wrote:
> +	} else {
> +		input_report_abs(touch->idev, ABS_PRESSURE, 0);
> +		input_report_abs(touch->idev, ABS_TOOL_WIDTH, 1);
> +		input_report_abs(touch->idev, BTN_TOUCH, 0);

This appears to be the only place ABS_TOOL_WIDTH is reported - could it
not just be omitted?
