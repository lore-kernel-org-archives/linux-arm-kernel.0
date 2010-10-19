From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Oct 2010 13:13:06 -0200
Subject: [PATCH 1/1] Mx35pdk: enable debug board support
In-Reply-To: <AANLkTim65XWxn_Mc59PXbiOOqUVMDNqeweU38y_3R7_X@mail.gmail.com>
References: <1287129633-9244-1-git-send-email-jgq516@gmail.com>
	<AANLkTikY=wBiJZ0NFKJKX-TTKRAj_LWmaxD-BpuPNYzL@mail.gmail.com>
	<AANLkTi=jyQDNmGK1-VB_xOP8H4+jXNwS6oHgft90gGLW@mail.gmail.com>
	<AANLkTim65XWxn_Mc59PXbiOOqUVMDNqeweU38y_3R7_X@mail.gmail.com>
Message-ID: <AANLkTi=upCD4iKhkvkzk7Kcb++OYR3pZTQw4i9fTEkFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xiao,
...

> I tried to use? MX35_PAD_GPIO1_1__GPIO1_1, but there isn't function to
> transform to irq num, so I added
> the pin definition in iomux-mx3.h. Is there any function can transform the
> PAD to irq num?

You can do the following:

#define EXPIO_PARENT_INT       IOMUX_TO_IRQ(MX35_PAD_GPIO1_1__GPIO1_1)

and also add MX35_PAD_GPIO1_1__GPIO1_1 into the mx35pdk_pads struct.

Regards,

Fabio Estevam
