From: van.freenix@gmail.com (Peng Fan)
Date: Fri, 29 Dec 2017 08:50:10 +0800
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable OP-TEE
In-Reply-To: <CAJKOXPc6mkUqyNK+qZvF_2Z9XK1W7H3GZQTMD5YyNbSeZC8U=w@mail.gmail.com>
References: <1514453660-15373-1-git-send-email-peng.fan@nxp.com>
 <1514453660-15373-2-git-send-email-peng.fan@nxp.com>
 <CAJKOXPc6mkUqyNK+qZvF_2Z9XK1W7H3GZQTMD5YyNbSeZC8U=w@mail.gmail.com>
Message-ID: <20171229005010.GB17906@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 28, 2017 at 02:03:01PM +0100, Krzysztof Kozlowski wrote:
>On Thu, Dec 28, 2017 at 10:34 AM, Peng Fan <peng.fan@nxp.com> wrote:
>> Enable OP-TEE for multi_v7_defconfig
>
>Why? You essentially copied here the subject of patch. That is not enough.

This patch could be dropped. Previously, I could not select OP-TEE in
imx_v6_v7_defconfig, seems things changed. I'll move this to imx_v6_v7_defconfig.

OP-TEE stands for Open Portable Trusted Execution Environment. With Linux
running in trustzone nonsecure world, OP-TEE runs in secure world,
with TEE/OP-TEE driver enabled, linux could use secure services provided
by OP-TEE. With TEE/OP-TEE options selected, we could use the following
node to let the driver probed.
"
        firmware {
			optee {
				compatible = "linaro,optee-tz";
				method = "smc";
			};
		};
"

Thanks,
Peng.
>
>Best regards,
>Krzysztof

-- 
