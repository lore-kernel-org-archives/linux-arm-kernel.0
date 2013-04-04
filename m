From: Mario.Smarduch@huawei.com (Mario Smarduch)
Date: Thu, 4 Apr 2013 14:48:18 +0000
Subject: Problem building 3.9rc5 - with CONFIG_AUTO_ZRELADDR
In-Reply-To: <2DDB038789B01B4B80B0D3F1FF7CBDC2064D2F5F@lhreml509-mbb.china.huawei.com>
References: <2DDB038789B01B4B80B0D3F1FF7CBDC2064D2F42@lhreml509-mbb.china.huawei.com>
 <2DDB038789B01B4B80B0D3F1FF7CBDC2064D2F5F@lhreml509-mbb.china.huawei.com>
Message-ID: <2DDB038789B01B4B80B0D3F1FF7CBDC2064D2F80@lhreml509-mbb.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm building 3.9rc5 Host the build fails in arch/arm/boot/Makefile.
check_for_multiple_loadaddr (issued from uImage:) checks if $(UIMAGE_LOADADDR) -ne 1.
With CONFIG_AUTO_ZRELADDR set kernel decompressed load address is determine dynamically.
The build doesn't seem to take that into consideration it expects ZRELADDR set.
3.8rc4 had 'if $(UIMAGE_LOADADDR) -gt 1', what I would expect.

Does someone know what's hidden behind this subtle change? Before looking for workarounds.

- Mario
