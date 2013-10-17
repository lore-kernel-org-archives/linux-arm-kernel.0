From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 17 Oct 2013 14:21:47 +0200
Subject: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
In-Reply-To: <525FD4C7.3050806@tabi.org>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <525FD4C7.3050806@tabi.org>
Message-ID: <525FD65B.3040004@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2013 02:15 PM, Timur Tabi wrote:
> Xiubo Li wrote:
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    sai->base = devm_ioremap_resource(&pdev->dev, res);
> 
> Why not use of_iomap()?

Because it won't check for conflicting resource regions.

- Lars
